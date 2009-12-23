package cn.benjamin.loxia.examples;

import javax.servlet.ServletContextEvent;
import javax.servlet.ServletContextListener;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;

import cn.benjamin.loxia.utils.DateUtil;
import cn.benjamin.loxia.web.LoxiaWebConstants;
import cn.benjamin.loxia.web.LoxiaWebSettings;

public class InitServletContextListener implements ServletContextListener {

	private static final Logger logger = LoggerFactory.getLogger(InitServletContextListener.class);
	
	public void contextDestroyed(ServletContextEvent sce) {
		
	}

	public void contextInitialized(ServletContextEvent sce) {
		logger.debug("Initialize context for application...");
		DateUtil.applyPattern(LoxiaWebSettings.getInstance().get(LoxiaWebConstants.DATE_PATTERN));
	}

}
