

<!DOCTYPE html>
<html>
	<head>
		<meta name="layout" content="main">
		<g:set var="entityName" value="${message(code: 'dependencia.label', default: 'Dependencia')}" />
		<title><g:message code="default.show.label" args="[entityName]" /></title>
	</head>
	<body>
		<a href="#show-dependencia" class="skip" tabindex="-1"><g:message code="default.link.skip.label" default="Skip to content&hellip;"/></a>
		<div class="nav" role="navigation">
			<ul>
				<li><a class="home" href="${createLink(uri: '/')}"><g:message code="default.home.label"/></a></li>
				<li><g:link class="list" action="list"><g:message code="default.list.label" args="[entityName]" /></g:link></li>
				<li><g:link class="create" action="create"><g:message code="default.new.label" args="[entityName]" /></g:link></li>
			</ul>
		</div>
		<div id="show-dependencia" class="content scaffold-show" role="main">
			<h1><g:message code="default.show.label" args="[entityName]" /></h1>
			<g:if test="${flash.message}">
			<div class="message" role="status">${flash.message}</div>
			</g:if>
			<ol class="property-list dependencia">
			
				<g:if test="${dependenciaInstance?.nombre}">
				<li class="fieldcontain">
					<span id="nombre-label" class="property-label"><g:message code="dependencia.nombre.label" default="Nombre" /></span>
					
						<span class="property-value" aria-labelledby="nombre-label"><g:fieldValue bean="${dependenciaInstance}" field="nombre"/></span>
					
				</li>
				</g:if>
			
				<g:if test="${dependenciaInstance?.calleNumero}">
				<li class="fieldcontain">
					<span id="calleNumero-label" class="property-label"><g:message code="dependencia.calleNumero.label" default="Calle Numero" /></span>
					
						<span class="property-value" aria-labelledby="calleNumero-label"><g:fieldValue bean="${dependenciaInstance}" field="calleNumero"/></span>
					
				</li>
				</g:if>
			
				<g:if test="${dependenciaInstance?.status}">
				<li class="fieldcontain">
					<span id="status-label" class="property-label"><g:message code="dependencia.status.label" default="Status" /></span>
					
						<span class="property-value" aria-labelledby="status-label"><g:formatBoolean boolean="${dependenciaInstance?.status}" /></span>
					
				</li>
				</g:if>
			
				<g:if test="${dependenciaInstance?.estado}">
				<li class="fieldcontain">
					<span id="estado-label" class="property-label"><g:message code="dependencia.estado.label" default="Estado" /></span>
					
						<span class="property-value" aria-labelledby="estado-label"><g:link controller="estado" action="show" id="${dependenciaInstance?.estado?.id}">${dependenciaInstance?.estado?.encodeAsHTML()}</g:link></span>
					
				</li>
				</g:if>
			
				<g:if test="${dependenciaInstance?.municipio}">
				<li class="fieldcontain">
					<span id="municipio-label" class="property-label"><g:message code="dependencia.municipio.label" default="Municipio" /></span>
					
						<span class="property-value" aria-labelledby="municipio-label"><g:link controller="municipio" action="show" id="${dependenciaInstance?.municipio?.id}">${dependenciaInstance?.municipio?.encodeAsHTML()}</g:link></span>
					
				</li>
				</g:if>
			
				<g:if test="${dependenciaInstance?.colonia}">
				<li class="fieldcontain">
					<span id="colonia-label" class="property-label"><g:message code="dependencia.colonia.label" default="Colonia" /></span>
					
						<span class="property-value" aria-labelledby="colonia-label"><g:fieldValue bean="${dependenciaInstance}" field="colonia"/></span>
					
				</li>
				</g:if>
			
				<g:if test="${dependenciaInstance?.cp}">
				<li class="fieldcontain">
					<span id="cp-label" class="property-label"><g:message code="dependencia.cp.label" default="Cp" /></span>
					
						<span class="property-value" aria-labelledby="cp-label"><g:fieldValue bean="${dependenciaInstance}" field="cp"/></span>
					
				</li>
				</g:if>
			
				<g:if test="${dependenciaInstance?.tipoDependencia}">
				<li class="fieldcontain">
					<span id="tipoDependencia-label" class="property-label"><g:message code="dependencia.tipoDependencia.label" default="Tipo Dependencia" /></span>
					
						<span class="property-value" aria-labelledby="tipoDependencia-label"><g:fieldValue bean="${dependenciaInstance}" field="tipoDependencia"/></span>
					
				</li>
				</g:if>
			
				<g:if test="${dependenciaInstance?.turnados}">
				<li class="fieldcontain">
					<span id="turnados-label" class="property-label"><g:message code="dependencia.turnados.label" default="Turnados" /></span>
					
						<g:each in="${dependenciaInstance.turnados}" var="t">
						<span class="property-value" aria-labelledby="turnados-label"><g:link controller="turnado" action="show" id="${t.id}">${t?.encodeAsHTML()}</g:link></span>
						</g:each>
					
				</li>
				</g:if>
			
			</ol>
			<g:form>
				<fieldset class="buttons">
					<g:hiddenField name="id" value="${dependenciaInstance?.id}" />
					<g:link class="edit" action="edit" id="${dependenciaInstance?.id}"><g:message code="default.button.edit.label" default="Edit" /></g:link>
					<g:actionSubmit class="delete" action="delete" value="${message(code: 'default.button.delete.label', default: 'Delete')}" onclick="return confirm('${message(code: 'default.button.delete.confirm.message', default: 'Are you sure?')}');" />
				</fieldset>
			</g:form>
		</div>
	</body>
</html>
