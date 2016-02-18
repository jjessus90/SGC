

<!DOCTYPE html>
<html>
	<head>
		<meta name="layout" content="main">
		<g:set var="entityName" value="${message(code: 'seguimiento.label', default: 'Seguimiento')}" />
		<title><g:message code="default.show.label" args="[entityName]" /></title>
	</head>
	<body>
		<a href="#show-seguimiento" class="skip" tabindex="-1"><g:message code="default.link.skip.label" default="Skip to content&hellip;"/></a>
		
		<div id="show-seguimiento" class="content scaffold-show" role="main">
			<h1><g:message code="default.show.label" args="[entityName]" /></h1>
			<g:if test="${flash.message}">
			<div class="message" role="status">${flash.message}</div>
			</g:if>
			<ol class="property-list seguimiento">
			
				<g:if test="${seguimientoInstance?.documento}">
				<li class="fieldcontain">
					<span id="documento-label" class="property-label"><g:message code="seguimiento.documento.label" default="Documento" /></span>
					
						<span class="property-value" aria-labelledby="documento-label">${seguimientoInstance?.documento?.encodeAsHTML()}</span>
					
				</li>
				</g:if>
			
				<g:if test="${seguimientoInstance?.fechaCaptura}">
				<li class="fieldcontain">
					<span id="fechaCaptura-label" class="property-label"><g:message code="seguimiento.fechaCaptura.label" default="Fecha Captura" /></span>
					
						<span class="property-value" aria-labelledby="fechaCaptura-label"><g:formatDate date="${seguimientoInstance?.fechaCaptura}" /></span>
					
				</li>
				</g:if>
			
				<g:if test="${seguimientoInstance?.seguimiento}">
				<li class="fieldcontain">
					<span id="seguimiento-label" class="property-label"><g:message code="seguimiento.seguimiento.label" default="Seguimiento" /></span>
					
						<span class="property-value" aria-labelledby="seguimiento-label"><g:fieldValue bean="${seguimientoInstance}" field="seguimiento"/></span>
					
				</li>
				</g:if>
			
			</ol>
			<g:form>
				<fieldset class="buttons">
					<g:hiddenField name="id" value="${seguimientoInstance?.id}" />
					<g:link class="edit" action="editTurnado" id="${seguimientoInstance?.id}"><g:message code="default.button.edit.label" default="Edit" /></g:link>
					
                                                                                           <g:link class="edit" action="showDocTurnado" controller="documento" id="${seguimientoInstance?.documento?.id}">Mostrar Documento</g:link>
                                </fieldset>
			</g:form>
		</div>
	</body>
</html>
