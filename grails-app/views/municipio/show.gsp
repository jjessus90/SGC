

<!DOCTYPE html>
<html>
	<head>
		<meta name="layout" content="main">
		<g:set var="entityName" value="${message(code: 'municipio.label', default: 'Municipio')}" />
		<title><g:message code="default.show.label" args="[entityName]" /></title>
	</head>
	<body>
		<a href="#show-municipio" class="skip" tabindex="-1"><g:message code="default.link.skip.label" default="Skip to content&hellip;"/></a>
		<div class="nav" role="navigation">
			<ul>
				<li><a class="home" href="${createLink(uri: '/')}"><g:message code="default.home.label"/></a></li>
				<li><g:link class="list" action="list"><g:message code="default.list.label" args="[entityName]" /></g:link></li>
				<li><g:link class="create" action="create"><g:message code="default.new.label" args="[entityName]" /></g:link></li>
			</ul>
		</div>
		<div id="show-municipio" class="content scaffold-show" role="main">
			<h1><g:message code="default.show.label" args="[entityName]" /></h1>
			<g:if test="${flash.message}">
			<div class="message" role="status">${flash.message}</div>
			</g:if>
			<ol class="property-list municipio">
			
				<g:if test="${municipioInstance?.nombre}">
				<li class="fieldcontain">
					<span id="nombre-label" class="property-label"><g:message code="municipio.nombre.label" default="Nombre" /></span>
					
						<span class="property-value" aria-labelledby="nombre-label"><g:fieldValue bean="${municipioInstance}" field="nombre"/></span>
					
				</li>
				</g:if>
			
				<g:if test="${municipioInstance?.dependencias}">
				<li class="fieldcontain">
					<span id="dependencias-label" class="property-label"><g:message code="municipio.dependencias.label" default="Dependencias" /></span>
					
						<g:each in="${municipioInstance.dependencias}" var="d">
						<span class="property-value" aria-labelledby="dependencias-label"><g:link controller="dependencia" action="show" id="${d.id}">${d?.encodeAsHTML()}</g:link></span>
						</g:each>
					
				</li>
				</g:if>
			
				<g:if test="${municipioInstance?.documentos}">
				<li class="fieldcontain">
					<span id="documentos-label" class="property-label"><g:message code="municipio.documentos.label" default="Documentos" /></span>
					
						<g:each in="${municipioInstance.documentos}" var="d">
						<span class="property-value" aria-labelledby="documentos-label"><g:link controller="documento" action="show" id="${d.id}">${d?.encodeAsHTML()}</g:link></span>
						</g:each>
					
				</li>
				</g:if>
			
			</ol>
			<g:form>
				<fieldset class="buttons">
					<g:hiddenField name="id" value="${municipioInstance?.id}" />
					<g:link class="edit" action="edit" id="${municipioInstance?.id}"><g:message code="default.button.edit.label" default="Edit" /></g:link>
					<g:actionSubmit class="delete" action="delete" value="${message(code: 'default.button.delete.label', default: 'Delete')}" onclick="return confirm('${message(code: 'default.button.delete.confirm.message', default: 'Are you sure?')}');" />
				</fieldset>
			</g:form>
		</div>
	</body>
</html>
