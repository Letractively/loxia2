package cn.benjamin.loxia.dao.support;

import java.io.Serializable;
import java.util.List;
import java.util.Map;

import javax.persistence.EntityManager;
import javax.persistence.PersistenceContext;
import javax.persistence.PersistenceException;
import javax.persistence.Query;

import org.hibernate.Session;
import org.hibernate.SessionFactory;
import org.hibernate.ejb.HibernateEntityManager;
import org.hibernate.ejb.HibernateQuery;
import org.hibernate.engine.EntityEntry;
import org.hibernate.engine.ForeignKeys;
import org.hibernate.engine.SessionImplementor;
import org.hibernate.engine.Status;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;

import cn.benjamin.loxia.dao.DaoService;
import cn.benjamin.loxia.dao.Sort;
import cn.benjamin.loxia.model.BaseModel;
import cn.benjamin.loxia.utils.StringUtil;

public class HibernateJpaDaoServiceImpl implements DaoService, Serializable {

	/**
	 * 
	 */
	private static final long serialVersionUID = 5388572435277626633L;
	
	protected static final Logger logger = LoggerFactory.getLogger(HibernateJpaDaoServiceImpl.class);
	
	/**
	 * TRANSIENT(NEW)
	 * PERSISTENT(MANAGED)
	 * DETACHED
	 * REMOVED(DELETED)
	 * @author benjamin
	 *
	 */
	private static enum EntityStatus {
		TRANSIENT,PERSISTENT,DETACHED,REMOVED
	}

	@PersistenceContext
	private EntityManager entityManager;
	
	public <T extends BaseModel> T save(T model) {
		if (EntityStatus.TRANSIENT == getStatus(model)) {
			entityManager.persist(model);
			return model;
		} else {
			return (T) entityManager.merge(model);
		}
	}
	
	public <T extends BaseModel> void delete(T model) {
		entityManager.remove(model);
	}

	public <T extends BaseModel> void deleteByPrimaryKey(Class<T> clazz, Serializable pk) {
		T entity = getByPrimaryKey(clazz, pk);
		if(entity != null)
			entityManager.remove(entity);
		else throw new PersistenceException("The entity you want to delete is not existed.");
	}

	public <T extends BaseModel> T getByPrimaryKey(Class<T> clazz,
			Serializable pk) {
		return (T) entityManager.find(clazz, pk);
	}
	
	private Session getSession() {
		if(!(entityManager instanceof HibernateEntityManager))
			throw new PersistenceException(
                    "Current entity manager is not an instance of HibernateEntityManager");
		// http://docs.jboss.org/hibernate/stable/entitymanager/api/org/hibernate/ejb/AbstractEntityManagerImpl.html#getDelegate()
		return (Session)entityManager.getDelegate();
	}
	
	private SessionFactory getSessionFactory(){
		return getSession().getSessionFactory();
	}
	
	private EntityStatus getStatus(BaseModel model){
		SessionImplementor simpl = (SessionImplementor)getSession();
		EntityEntry entry = simpl.getPersistenceContext().getEntry(model);
		if(entry != null){
			//Persistent Object
			logger.debug("current {} is one Entity with entry in PersistenceContext.", model);
			if (entry.getStatus() != Status.DELETED) {
				logger.debug("EntityStatus: {}", EntityStatus.PERSISTENT );
				return EntityStatus.PERSISTENT;
			} else {
				logger.debug("EntityStatus: {}", EntityStatus.REMOVED );
				return EntityStatus.REMOVED;
			}
		}else{
			//Detached or Transient Object
			logger.debug("current {} is one Entity without entry in PersistenceContext.", model);
			if (ForeignKeys.isTransient(null, model, null, simpl)) {
				logger.debug("EntityStatus: {}", EntityStatus.TRANSIENT );
				return EntityStatus.TRANSIENT;
			} else {
				logger.debug("EntityStatus: {}", EntityStatus.DETACHED );
				return EntityStatus.DETACHED;
			}
		}
	}

	public int batchUpdateByNamedQuery(String queryName, Map<String,Object> params) {
		Query query = entityManager.createNamedQuery(queryName);
		for(String key: params.keySet()){
			query.setParameter(key, params.get(key));
		}
		return query.executeUpdate();
	}
	
	public int batchUpdateByQuery(String queryString, Map<String, Object> params) {
		Query query = entityManager.createQuery(queryString);
		for(String key: params.keySet()){
			query.setParameter(key, params.get(key));
		}
		return query.executeUpdate();
	}

	public <T> List<T> findByNamedQuery(String queryName, Map<String,Object> params) {
		return findByNamedQuery(queryName, params, -1, -1);
	}
	
	@SuppressWarnings("unchecked")
	public <T> List<T> findByNamedQuery(String queryName, Map<String,Object> params, int start, int pageSize) {
		Query query = entityManager.createNamedQuery(queryName);
		for(String key: params.keySet()){
			query.setParameter(key, params.get(key));
		}
		if(start > 0)
			query.setFirstResult(start);
		if(pageSize > 0)
			query.setMaxResults(pageSize);
		return (List<T>)query.getResultList();
	}
	
	public <T> List<T> findByQuery(String queryString, Map<String, Object> params) {
		return findByQuery(queryString, params, null, -1, -1);
	}
	
	public <T> List<T> findByQuery(String queryString, Map<String, Object> params,
			Sort[] sorts) {
		return findByQuery(queryString, params, sorts, -1, -1);
	}
	
	public <T> List<T> findByQuery(String queryString, Map<String, Object> params, int start, int pageSize) {
		return findByQuery(queryString, params, null, start, pageSize);
	}
	
	@SuppressWarnings("unchecked")
	public <T> List<T> findByQuery(String queryString, Map<String, Object> params,
			Sort[] sorts, int start, int pageSize) {
		if(sorts != null && sorts.length > 0){
			queryString += " order by " + StringUtil.join(sorts);
		}
		Query query = entityManager.createQuery(queryString);
		for(String key: params.keySet()){
			query.setParameter(key, params.get(key));
		}
		if(start > 0)
			query.setFirstResult(start);
		if(pageSize > 0)
			query.setMaxResults(pageSize);
		return (List<T>)query.getResultList();
	}

	public <T> T findOneByNamedQuery(String queryName, Map<String,Object> params) {
		List<T> list = findByNamedQuery(queryName, params);
		if(list.isEmpty())
			return null;
		return list.get(0);
	}
	
	public <T> T findOneByQuery(String queryString, Map<String,Object> params){
		List<T> list = findByQuery(queryString, params, null);
		if(list.isEmpty())
			return null;
		return list.get(0);
	}

	public <T> List<T> findByNamedQuery(String queryName,
			Map<String, Object> params, Sort[] sorts) {
		return findByNamedQuery(queryName, params, sorts, -1, -1);
	}

	public <T> List<T> findByNamedQuery(String queryName,
			Map<String, Object> params, Sort[] sorts, int start, int pageSize) {
		Query query = entityManager.createNamedQuery(queryName);
		HibernateQuery hQuery = (HibernateQuery) query;
		return findByQuery(hQuery.getHibernateQuery().getQueryString(), params, sorts, start, pageSize);
	}

}