

<!DOCTYPE html>
<html>
	<head>
		<meta name="layout" content="main">
		<g:set var="entityName" value="${message(code: 'turnadoTarjeta.label', default: 'TurnadoTarjeta')}" />
		<title><g:message code="default.show.label" args="[entityName]" /></title>
	</head>
	<body>
		<a href="#show-turnadoTarjeta" class="skip" tabindex="-1"><g:message code="default.link.skip.label" default="Skip to content&hellip;"/></a>
		<div class="nav" role="navigation">
			<ul>
				<li><a class="home" href="${createLink(uri: '/')}"><g:message code="default.home.label"/></a></li>
				<li><g:link class="list" action="list"><g:message code="default.list.label" args="[entityName]" /></g:link></li>
				<li><g:link class="create" action="create"><g:message code="default.new.label" args="[entityName]" /></g:link></li>
			</ul>
		</div>
		<div id="show-turnadoTarjeta" class="content scaffold-show" role="main">
			<h1><g:message code="default.show.label" args="[entityName]" /></h1>
			<g:if test="${flash.message}">
			<div class="message" role="status">${flash.message}</div>
			</g:if>
			<ol class="property-list turnadoTarjeta">
			
				<g:if test="${turnadoTarjetaInstance?.dependencia}">
				<li class="fieldcontain">
					<span id="dependencia-label" class="property-label"><g:message code="turnadoTarjeta.dependencia.label" default="Dependencia" /></span>
					
						<span class="property-value" aria-labelledby="dependencia-label"><g:link controller="dependencia" action="show" id="${turnadoTarjetaInstance?.dependencia?.id}">${turnadoTarjetaInstance?.dependencia?.encodeAsHTML()}</g:link></span>
					
				</li>
				</g:if>
			
				<g:if test="${turnadoTarjetaInstance?.usuarioSistema}">
				<li class="fieldcontain">
					<span id="usuarioSistema-label" class="property-label"><g:message code="turnadoTarjeta.usuarioSistema.label" default="Usuario Sistema" /></span>
					
						<span class="property-value" aria-labelledby="usuarioSistema-label"><g:link controller="usuarioSistema" action="show" id="${turnadoTarjetaInstance?.usuarioSistema?.id}">${turnadoTarjetaInstance?.usuarioSistema?.encodeAsHTML()}</g:link></span>
					
				</li>
				</g:if>
			
				<g:if test="${turnadoTarjetaInstance?.tarjetaInformativa}">
				<li class="fieldcontain">
					<span id="tarjetaInformativa-label" class="property-label"><g:message code="turnadoTarjeta.tarjetaInformativa.label" default="Tarjeta Informativa" /></span>
					
						<span class="property-value" aria-labelledby="tarjetaInformativa-label"><g:link controller="tarjetaInformativa" action="show" id="${turnadoTarjetaInstance?.tarjetaInformativa?.id}">${turnadoTarjetaInstance?.tarjetaInformativa?.encodeAsHTML()}</g:link></span>
					
				</li>
				</g:if>
			
				<g:if test="${turnadoTarjetaInstance?.fechaTurnado}">
				<li class="fieldcontain">
					<span id="fechaTurnado-label" class="property-label"><g:message code="turnadoTarjeta.fechaTurnado.label" default="Fecha Turnado" /></span>
					
						<span class="property-value" aria-labelledby="fechaTurnado-label"><g:formatDate date="${turnadoTarjetaInstance?.fechaTurnado}" /></span>
					
				</li>
				</g:if>
			
				<g:if test="${turnadoTarjetaInstance?.status}">
				<li class="fieldcontain">
					<span id="status-label" class="property-label"><g:message code="turnadoTarjeta.status.label" default="Status" /></span>
					
						<span class="property-value" aria-labelledby="status-label"><g:formatBoolean boolean="${turnadoTarjetaInstance?.status}" /></span>
					
				</li>
				</g:if>
			
				<g:if test="${turnadoTarjetaInstance?.persona}">
				<li class="fieldcontain">
					<span id="persona-label" class="property-label"><g:message code="turnadoTarjeta.persona.label" default="Persona" /></span>
					
						<span class="property-value" aria-labelledby="persona-label"><g:link controller="persona" action="show" id="${turnadoTarjetaInstance?.persona?.id}">${turnadoTarjetaInstance?.persona?.encodeAsHTML()}</g:link></span>
					
				</li>
				</g:if>
			
			</ol>
			<g:form>
				<fieldset class="buttons">
					<g:hiddenField name="id" value="${turnadoTarjetaInstance?.id}" />
					<g:link class="edit" action="edit" id="${turnadoTarjetaInstance?.id}"><g:message code="default.button.edit.label" default="Edit" /></g:link>
					<g:actionSubmit class="delete" action="delete" value="${message(code: 'default.button.delete.label', default: 'Delete')}" onclick="return confirm('${message(code: 'default.button.delete.confirm.message', default: 'Are you sure?')}');" />
				</fieldset>
			</g:form>
		</div>
	</body>
</html>
