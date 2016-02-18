

<!DOCTYPE html>
<html>
	<head>
		<meta name="layout" content="main">
		<g:set var="entityName" value="${message(code: 'persona.label', default: 'Persona')}" />
		<title><g:message code="default.show.label" args="[entityName]" /></title>
	</head>
	<body>
		<a href="#show-persona" class="skip" tabindex="-1"><g:message code="default.link.skip.label" default="Skip to content&hellip;"/></a>
		<div class="nav" role="navigation">
			<ul>
				<li><a class="home" href="${createLink(uri: '/')}"><g:message code="default.home.label"/></a></li>
				<li><g:link class="list" action="list"><g:message code="default.list.label" args="[entityName]" /></g:link></li>
				<li><g:link class="create" action="create"><g:message code="default.new.label" args="[entityName]" /></g:link></li>
			</ul>
		</div>
		<div id="show-persona" class="content scaffold-show" role="main">
			<h1><g:message code="default.show.label" args="[entityName]" /></h1>
			<g:if test="${flash.message}">
			<div class="message" role="status">${flash.message}</div>
			</g:if>
			<ol class="property-list persona">
			
				<g:if test="${personaInstance?.nombre}">
				<li class="fieldcontain">
					<span id="nombre-label" class="property-label"><g:message code="persona.nombre.label" default="Nombre" /></span>
					
						<span class="property-value" aria-labelledby="nombre-label"><g:fieldValue bean="${personaInstance}" field="nombre"/></span>
					
				</li>
				</g:if>
			
				<g:if test="${personaInstance?.correo}">
				<li class="fieldcontain">
					<span id="correo-label" class="property-label"><g:message code="persona.correo.label" default="Correo" /></span>
					
						<span class="property-value" aria-labelledby="correo-label"><g:fieldValue bean="${personaInstance}" field="correo"/></span>
					
				</li>
				</g:if>
			
				<g:if test="${personaInstance?.calleNumero}">
				<li class="fieldcontain">
					<span id="calleNumero-label" class="property-label"><g:message code="persona.calleNumero.label" default="Calle Numero" /></span>
					
						<span class="property-value" aria-labelledby="calleNumero-label"><g:fieldValue bean="${personaInstance}" field="calleNumero"/></span>
					
				</li>
				</g:if>
			
				<g:if test="${personaInstance?.cargo}">
				<li class="fieldcontain">
					<span id="cargo-label" class="property-label"><g:message code="persona.cargo.label" default="Cargo" /></span>
					
						<span class="property-value" aria-labelledby="cargo-label"><g:fieldValue bean="${personaInstance}" field="cargo"/></span>
					
				</li>
				</g:if>
			
				<g:if test="${personaInstance?.colonia}">
				<li class="fieldcontain">
					<span id="colonia-label" class="property-label"><g:message code="persona.colonia.label" default="Colonia" /></span>
					
						<span class="property-value" aria-labelledby="colonia-label"><g:fieldValue bean="${personaInstance}" field="colonia"/></span>
					
				</li>
				</g:if>
			
				<g:if test="${personaInstance?.cp}">
				<li class="fieldcontain">
					<span id="cp-label" class="property-label"><g:message code="persona.cp.label" default="Cp" /></span>
					
						<span class="property-value" aria-labelledby="cp-label"><g:fieldValue bean="${personaInstance}" field="cp"/></span>
					
				</li>
				</g:if>
			
				<g:if test="${personaInstance?.dependencia}">
				<li class="fieldcontain">
					<span id="dependencia-label" class="property-label"><g:message code="persona.dependencia.label" default="Dependencia" /></span>
					
						<span class="property-value" aria-labelledby="dependencia-label"><g:link controller="dependencia" action="show" id="${personaInstance?.dependencia?.id}">${personaInstance?.dependencia?.encodeAsHTML()}</g:link></span>
					
				</li>
				</g:if>
			
				<g:if test="${personaInstance?.documentos}">
				<li class="fieldcontain">
					<span id="documentos-label" class="property-label"><g:message code="persona.documentos.label" default="Documentos" /></span>
					
						<g:each in="${personaInstance.documentos}" var="d">
						<span class="property-value" aria-labelledby="documentos-label"><g:link controller="documento" action="show" id="${d.id}">${d?.encodeAsHTML()}</g:link></span>
						</g:each>
					
				</li>
				</g:if>
			
				<g:if test="${personaInstance?.estado}">
				<li class="fieldcontain">
					<span id="estado-label" class="property-label"><g:message code="persona.estado.label" default="Estado" /></span>
					
						<span class="property-value" aria-labelledby="estado-label"><g:link controller="estado" action="show" id="${personaInstance?.estado?.id}">${personaInstance?.estado?.encodeAsHTML()}</g:link></span>
					
				</li>
				</g:if>
			
				<g:if test="${personaInstance?.municipio}">
				<li class="fieldcontain">
					<span id="municipio-label" class="property-label"><g:message code="persona.municipio.label" default="Municipio" /></span>
					
						<span class="property-value" aria-labelledby="municipio-label"><g:link controller="municipio" action="show" id="${personaInstance?.municipio?.id}">${personaInstance?.municipio?.encodeAsHTML()}</g:link></span>
					
				</li>
				</g:if>
			
				<g:if test="${personaInstance?.tel}">
				<li class="fieldcontain">
					<span id="tel-label" class="property-label"><g:message code="persona.tel.label" default="Tel" /></span>
					
						<span class="property-value" aria-labelledby="tel-label"><g:fieldValue bean="${personaInstance}" field="tel"/></span>
					
				</li>
				</g:if>
			
				<g:if test="${personaInstance?.turnados}">
				<li class="fieldcontain">
					<span id="turnados-label" class="property-label"><g:message code="persona.turnados.label" default="Turnados" /></span>
					
						<g:each in="${personaInstance.turnados}" var="t">
						<span class="property-value" aria-labelledby="turnados-label"><g:link controller="turnado" action="show" id="${t.id}">${t?.encodeAsHTML()}</g:link></span>
						</g:each>
					
				</li>
				</g:if>
			
			</ol>
			<g:form>
				<fieldset class="buttons">
					<g:hiddenField name="id" value="${personaInstance?.id}" />
					<g:link class="edit" action="edit" id="${personaInstance?.id}"><g:message code="default.button.edit.label" default="Edit" /></g:link>
					<g:actionSubmit class="delete" action="delete" value="${message(code: 'default.button.delete.label', default: 'Delete')}" onclick="return confirm('${message(code: 'default.button.delete.confirm.message', default: 'Are you sure?')}');" />
				</fieldset>
			</g:form>
		</div>
	</body>
</html>
