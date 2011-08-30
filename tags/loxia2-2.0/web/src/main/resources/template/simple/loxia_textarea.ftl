<textarea loxiaType="input"<#rt/>
 name="${parameters.name?default("")?html}"<#rt/>
 cols="${parameters.cols?default("")?html}"<#rt/>
 rows="${parameters.rows?default("")?html}"<#rt/>
<#if parameters.wrap?exists>
 wrap="${parameters.wrap?html}"<#rt/>
</#if>
<#if parameters.disabled?default(false)>
 disabled="disabled"<#rt/>
</#if>
<#if parameters.readonly?default(false)>
 readonly="true"<#rt/>
</#if>
<#if parameters.required?default(false)>
 required="true"<#rt/>
</#if>
<#if parameters.checkmaster?exists>
 checkmaster="${parameters.checkmaster?html}"<#rt/>
</#if>
<#if parameters.htmlAttr?exists>
 ${parameters.htmlAttr?html}<#rt/>
</#if>
<#if parameters.tabindex?exists>
 tabindex="${parameters.tabindex?html}"<#rt/>
</#if>
<#if parameters.id?exists>
 id="${parameters.id?html}"<#rt/>
</#if>
<#if parameters.cssClass?exists>
 class="${parameters.cssClass?html}"<#rt/>
</#if>
<#if parameters.cssStyle?exists>
 style="${parameters.cssStyle?html}"<#rt/>
</#if>
<#if parameters.title?exists>
 title="${parameters.title?html}"<#rt/>
</#if>
<#include "/${parameters.templateDir}/simple/scripting-events.ftl" />
<#include "/${parameters.templateDir}/simple/common-attributes.ftl" />
><#rt/>
<#if parameters.nameValue?exists>
<@s.property value="parameters.nameValue"/><#t/>
</#if>