

<!DOCTYPE html>
<html>
	<head>
		<meta name="layout" content="main">
		<g:set var="entityName" value="${message(code: 'respuesta.label', default: 'Respuesta')}" />
		<title><g:message code="default.show.label" args="[entityName]" /></title>
	</head>
	<body>
		<a href="#show-respuesta" class="skip" tabindex="-1"><g:message code="default.link.skip.label" default="Skip to content&hellip;"/></a>
		<div class="nav" role="navigation">
			<ul>
				<li><a class="home" href="${createLink(uri: '/')}"><g:message code="default.home.label"/></a></li>
				<li><g:link class="list" action="list"><g:message code="default.list.label" args="[entityName]" /></g:link></li>
				<li><g:link class="create" action="create"><g:message code="default.new.label" args="[entityName]" /></g:link></li>
			</ul>
		</div>
		<div id="show-respuesta" class="content scaffold-show" role="main">
			<h1><g:message code="default.show.label" args="[entityName]" /></h1>
			<g:if test="${flash.message}">
			<div class="message" role="status">${flash.message}</div>
			</g:if>
			<ol class="property-list respuesta">
			
				<g:if test="${respuestaInstance?.documento}">
				<li class="fieldcontain">
					<span id="documento-label" class="property-label"><g:message code="respuesta.documento.label" default="Documento" /></span>
					
						<span class="property-value" aria-labelledby="documento-label"><g:link controller="documento" action="show" id="${respuestaInstance?.documento?.id}">${respuestaInstance?.documento?.encodeAsHTML()}</g:link></span>
					
				</li>
				</g:if>
			
				<g:if test="${respuestaInstance?.fechaCaptura}">
				<li class="fieldcontain">
					<span id="fechaCaptura-label" class="property-label"><g:message code="respuesta.fechaCaptura.label" default="Fecha Captura" /></span>
					
						<span class="property-value" aria-labelledby="fechaCaptura-label"><g:formatDate date="${respuestaInstance?.fechaCaptura}" /></span>
					
				</li>
				</g:if>
			
				<g:if test="${respuestaInstance?.respuesta}">
				<li class="fieldcontain">
					<span id="respuesta-label" class="property-label"><g:message code="respuesta.respuesta.label" default="Respuesta" /></span>
					
						<span class="property-value" aria-labelledby="respuesta-label"><g:fieldValue bean="${respuestaInstance}" field="respuesta"/></span>
					
				</li>
				</g:if>
			
				<g:if test="${respuestaInstance?.usuarioSistema}">
				<li class="fieldcontain">
					<span id="usuarioSistema-label" class="property-label"><g:message code="respuesta.usuarioSistema.label" default="Usuario Sistema" /></span>
					
						<span class="property-value" aria-labelledby="usuarioSistema-label"><g:link controller="usuarioSistema" action="show" id="${respuestaInstance?.usuarioSistema?.id}">${respuestaInstance?.usuarioSistema?.encodeAsHTML()}</g:link></span>
					
				</li>
				</g:if>
			
			</ol>
			<g:form>
				<fieldset class="buttons">
					<g:hiddenField name="id" value="${respuestaInstance?.id}" />
					<g:link class="edit" action="edit" id="${respuestaInstance?.id}"><g:message code="default.button.edit.label" default="Edit" /></g:link>
					<g:actionSubmit class="delete" action="delete" value="${message(code: 'default.button.delete.label', default: 'Delete')}" onclick="return confirm('${message(code: 'default.button.delete.confirm.message', default: 'Are you sure?')}');" />
				</fieldset>
			</g:form>
		</div>
	</body>
</html>
