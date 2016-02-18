

<!DOCTYPE html>
<html>
	<head>
		<meta name="layout" content="main">
		<g:set var="entityName" value="${message(code: 'seguimientoTarjeta.label', default: 'SeguimientoTarjeta')}" />
		<title><g:message code="default.show.label" args="[entityName]" /></title>
	</head>
	<body>
		<a href="#show-seguimientoTarjeta" class="skip" tabindex="-1"><g:message code="default.link.skip.label" default="Skip to content&hellip;"/></a>
		<div class="nav" role="navigation">
			<ul>
				<li><a class="home" href="${createLink(uri: '/')}"><g:message code="default.home.label"/></a></li>
				<li><g:link class="list" action="list"><g:message code="default.list.label" args="[entityName]" /></g:link></li>
				<li><g:link class="create" action="create"><g:message code="default.new.label" args="[entityName]" /></g:link></li>
			</ul>
		</div>
		<div id="show-seguimientoTarjeta" class="content scaffold-show" role="main">
			<h1><g:message code="default.show.label" args="[entityName]" /></h1>
			<g:if test="${flash.message}">
			<div class="message" role="status">${flash.message}</div>
			</g:if>
			<ol class="property-list seguimientoTarjeta">
			
				<g:if test="${seguimientoTarjetaInstance?.tarjetaInformativa}">
				<li class="fieldcontain">
					<span id="tarjetaInformativa-label" class="property-label"><g:message code="seguimientoTarjeta.tarjetaInformativa.label" default="Tarjeta Informativa" /></span>
					
						<span class="property-value" aria-labelledby="tarjetaInformativa-label"><g:link controller="tarjetaInformativa" action="show" id="${seguimientoTarjetaInstance?.tarjetaInformativa?.id}">${seguimientoTarjetaInstance?.tarjetaInformativa?.encodeAsHTML()}</g:link></span>
					
				</li>
				</g:if>
			
				<g:if test="${seguimientoTarjetaInstance?.fechaCaptura}">
				<li class="fieldcontain">
					<span id="fechaCaptura-label" class="property-label"><g:message code="seguimientoTarjeta.fechaCaptura.label" default="Fecha Captura" /></span>
					
						<span class="property-value" aria-labelledby="fechaCaptura-label"><g:formatDate date="${seguimientoTarjetaInstance?.fechaCaptura}" /></span>
					
				</li>
				</g:if>
			
				<g:if test="${seguimientoTarjetaInstance?.seguimiento}">
				<li class="fieldcontain">
					<span id="seguimiento-label" class="property-label"><g:message code="seguimientoTarjeta.seguimiento.label" default="Seguimiento" /></span>
					
						<span class="property-value" aria-labelledby="seguimiento-label"><g:fieldValue bean="${seguimientoTarjetaInstance}" field="seguimiento"/></span>
					
				</li>
				</g:if>
			
				<g:if test="${seguimientoTarjetaInstance?.usuarioSistema}">
				<li class="fieldcontain">
					<span id="usuarioSistema-label" class="property-label"><g:message code="seguimientoTarjeta.usuarioSistema.label" default="Usuario Sistema" /></span>
					
						<span class="property-value" aria-labelledby="usuarioSistema-label"><g:link controller="usuarioSistema" action="show" id="${seguimientoTarjetaInstance?.usuarioSistema?.id}">${seguimientoTarjetaInstance?.usuarioSistema?.encodeAsHTML()}</g:link></span>
					
				</li>
				</g:if>
			
			</ol>
			<g:form>
				<fieldset class="buttons">
					<g:hiddenField name="id" value="${seguimientoTarjetaInstance?.id}" />
					<g:link class="edit" action="edit" id="${seguimientoTarjetaInstance?.id}"><g:message code="default.button.edit.label" default="Edit" /></g:link>
					<g:actionSubmit class="delete" action="delete" value="${message(code: 'default.button.delete.label', default: 'Delete')}" onclick="return confirm('${message(code: 'default.button.delete.confirm.message', default: 'Are you sure?')}');" />
				</fieldset>
			</g:form>
		</div>
	</body>
</html>
