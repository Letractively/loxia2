package cn.benjamin.loxia.spring;

import org.springframework.beans.factory.xml.NamespaceHandlerSupport;

public class LoxiaNamespaceHandler extends NamespaceHandlerSupport {

	public void init() {
		registerBeanDefinitionParser("dao", new GenericDaoBeanDefinitionParser());
	}

}