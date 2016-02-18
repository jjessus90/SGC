

<!DOCTYPE html>
<html>
	<head>
		<meta name="layout" content="main">
		<g:set var="entityName" value="${message(code: 'indicacion.label', default: 'Indicacion')}" />
		<title><g:message code="default.show.label" args="[entityName]" /></title>
	</head>
	<body>
		<a href="#show-indicacion" class="skip" tabindex="-1"><g:message code="default.link.skip.label" default="Skip to content&hellip;"/></a>
		<div class="nav" role="navigation">
			<ul>
				<li><a class="home" href="${createLink(uri: '/')}"><g:message code="default.home.label"/></a></li>
				<li><g:link class="list" action="list"><g:message code="default.list.label" args="[entityName]" /></g:link></li>
				<li><g:link class="create" action="create"><g:message code="default.new.label" args="[entityName]" /></g:link></li>
			</ul>
		</div>
		<div id="show-indicacion" class="content scaffold-show" role="main">
			<h1><g:message code="default.show.label" args="[entityName]" /></h1>
			<g:if test="${flash.message}">
			<div class="message" role="status">${flash.message}</div>
			</g:if>
			<ol class="property-list indicacion">
			
				<g:if test="${indicacionInstance?.indicacion}">
				<li class="fieldcontain">
					<span id="indicacion-label" class="property-label"><g:message code="indicacion.indicacion.label" default="Indicacion" /></span>
					
						<span class="property-value" aria-labelledby="indicacion-label"><g:fieldValue bean="${indicacionInstance}" field="indicacion"/></span>
					
				</li>
				</g:if>
			
				<g:if test="${indicacionInstance?.documentos}">
				<li class="fieldcontain">
					<span id="documentos-label" class="property-label"><g:message code="indicacion.documentos.label" default="Documentos" /></span>
					
						<g:each in="${indicacionInstance.documentos}" var="d">
						<span class="property-value" aria-labelledby="documentos-label"><g:link controller="documento" action="show" id="${d.id}">${d?.encodeAsHTML()}</g:link></span>
						</g:each>
					
				</li>
				</g:if>
			
			</ol>
			<g:form>
				<fieldset class="buttons">
					<g:hiddenField name="id" value="${indicacionInstance?.id}" />
					<g:link class="edit" action="edit" id="${indicacionInstance?.id}"><g:message code="default.button.edit.label" default="Edit" /></g:link>
					<g:actionSubmit class="delete" action="delete" value="${message(code: 'default.button.delete.label', default: 'Delete')}" onclick="return confirm('${message(code: 'default.button.delete.confirm.message', default: 'Are you sure?')}');" />
				</fieldset>
			</g:form>
		</div>
	</body>
</html>
