

<!DOCTYPE html>
<html>
	<head>
		<meta name="layout" content="main">
		<g:set var="entityName" value="${message(code: 'turnadoTarjeta.label', default: 'TurnadoTarjeta')}" />
		<title><g:message code="default.list.label" args="[entityName]" /></title>
	</head>
	<body>
		<a href="#list-turnadoTarjeta" class="skip" tabindex="-1"><g:message code="default.link.skip.label" default="Skip to content&hellip;"/></a>
		<div class="nav" role="navigation">
			<ul>
				<li><a class="home" href="${createLink(uri: '/')}"><g:message code="default.home.label"/></a></li>
				<li><g:link class="create" action="create"><g:message code="default.new.label" args="[entityName]" /></g:link></li>
			</ul>
		</div>
		<div id="list-turnadoTarjeta" class="content scaffold-list" role="main">
			<h1><g:message code="default.list.label" args="[entityName]" /></h1>
			<g:if test="${flash.message}">
			<div class="message" role="status">${flash.message}</div>
			</g:if>
			<table>
				<thead>
					<tr>
					
						<th><g:message code="turnadoTarjeta.dependencia.label" default="Dependencia" /></th>
					
						<th><g:message code="turnadoTarjeta.usuarioSistema.label" default="Usuario Sistema" /></th>
					
						<th><g:message code="turnadoTarjeta.tarjetaInformativa.label" default="Tarjeta Informativa" /></th>
					
						<g:sortableColumn property="fechaTurnado" title="${message(code: 'turnadoTarjeta.fechaTurnado.label', default: 'Fecha Turnado')}" />
					
						<g:sortableColumn property="status" title="${message(code: 'turnadoTarjeta.status.label', default: 'Status')}" />
					
						<th><g:message code="turnadoTarjeta.persona.label" default="Persona" /></th>
					
					</tr>
				</thead>
				<tbody>
				<g:each in="${turnadoTarjetaInstanceList}" status="i" var="turnadoTarjetaInstance">
					<tr class="${(i % 2) == 0 ? 'even' : 'odd'}">
					
						<td><g:link action="show" id="${turnadoTarjetaInstance.id}">${fieldValue(bean: turnadoTarjetaInstance, field: "dependencia")}</g:link></td>
					
						<td>${fieldValue(bean: turnadoTarjetaInstance, field: "usuarioSistema")}</td>
					
						<td>${fieldValue(bean: turnadoTarjetaInstance, field: "tarjetaInformativa")}</td>
					
						<td><g:formatDate date="${turnadoTarjetaInstance.fechaTurnado}" /></td>
					
						<td><g:formatBoolean boolean="${turnadoTarjetaInstance.status}" /></td>
					
						<td>${fieldValue(bean: turnadoTarjetaInstance, field: "persona")}</td>
					
					</tr>
				</g:each>
				</tbody>
			</table>
			<div class="pagination">
				<g:paginate total="${turnadoTarjetaInstanceTotal}" />
			</div>
		</div>
	</body>
</html>
