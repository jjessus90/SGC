

<!DOCTYPE html>
<html>
	<head>
		<meta name="layout" content="main">
		<g:set var="entityName" value="${message(code: 'turnado.label', default: 'Turnado')}" />
		<title><g:message code="default.show.label" args="[entityName]" /></title>
	</head>
	<body>
		<a href="#show-turnado" class="skip" tabindex="-1"><g:message code="default.link.skip.label" default="Skip to content&hellip;"/></a>
		<div class="nav" role="navigation">
			<ul>
				<li><a class="home" href="${createLink(uri: '/')}"><g:message code="default.home.label"/></a></li>
				<li><g:link class="list" action="list"><g:message code="default.list.label" args="[entityName]" /></g:link></li>
				
			</ul>
		</div>
		<div id="show-turnado" class="content scaffold-show" role="main">
			<h1><g:message code="default.show.label" args="[entityName]" /></h1>
			<g:if test="${flash.message}">
			<div class="message" role="status">${flash.message}</div>
			</g:if>
			<ol class="property-list turnado">
			
			
				<g:if test="${turnadoInstance?.dependencia}">
				<li class="fieldcontain">
					<span id="dependencia-label" class="property-label"><g:message code="turnado.dependencia.label" default="Dependencia" /></span>
					
						<span class="property-value" aria-labelledby="dependencia-label"><g:link controller="dependencia" action="show" id="${turnadoInstance?.dependencia?.id}">${turnadoInstance?.dependencia?.encodeAsHTML()}</g:link></span>
					
				</li>
				</g:if>
			
				<g:if test="${turnadoInstance?.usuarioSistema}">
				<li class="fieldcontain">
					<span id="usuarioSistema-label" class="property-label"><g:message code="turnado.usuarioSistema.label" default="Usuario Sistema" /></span>
					
						<span class="property-value" aria-labelledby="usuarioSistema-label"><g:link controller="usuarioSistema" action="show" id="${turnadoInstance?.usuarioSistema?.id}">${turnadoInstance?.usuarioSistema?.encodeAsHTML()}</g:link></span>
					
				</li>
				</g:if>
			
				<g:if test="${turnadoInstance?.documento}">
				<li class="fieldcontain">
					<span id="documento-label" class="property-label"><g:message code="turnado.documento.label" default="Documento" /></span>
					
						<span class="property-value" aria-labelledby="documento-label"><g:link controller="documento" action="show" id="${turnadoInstance?.documento?.id}">${turnadoInstance?.documento?.encodeAsHTML()}</g:link></span>
					
				</li>
				</g:if>
			
				<g:if test="${turnadoInstance?.fechaTerminacion}">
				<li class="fieldcontain">
					<span id="fechaTerminacion-label" class="property-label"><g:message code="turnado.fechaTerminacion.label" default="Fecha Terminacion" /></span>
					
						<span class="property-value" aria-labelledby="fechaTerminacion-label"><g:formatDate date="${turnadoInstance?.fechaTerminacion}" /></span>
					
				</li>
				</g:if>
			
				<g:if test="${turnadoInstance?.fechaTurnado}">
				<li class="fieldcontain">
					<span id="fechaTurnado-label" class="property-label"><g:message code="turnado.fechaTurnado.label" default="Fecha Turnado" /></span>
					
						<span class="property-value" aria-labelledby="fechaTurnado-label"><g:formatDate date="${turnadoInstance?.fechaTurnado}" /></span>
					
				</li>
				</g:if>
			
					
				<g:if test="${turnadoInstance?.status}">
				<li class="fieldcontain">
					<span id="status-label" class="property-label"><g:message code="turnado.status.label" default="Status" /></span>
					
						<span class="property-value" aria-labelledby="status-label"><g:formatBoolean boolean="${turnadoInstance?.status}" /></span>
					
				</li>
				</g:if>
			
			</ol>
			<g:form>
				<fieldset class="buttons">
					<g:hiddenField name="id" value="${turnadoInstance?.id}" />
					<g:link class="edit" action="edit" id="${turnadoInstance?.id}"><g:message code="default.button.edit.label" default="Edit" /></g:link>
					<g:actionSubmit class="delete" action="delete" value="${message(code: 'default.button.delete.label', default: 'Delete')}" onclick="return confirm('${message(code: 'default.button.delete.confirm.message', default: 'Are you sure?')}');" />
				</fieldset>
			</g:form>
		</div>
	</body>
</html>
