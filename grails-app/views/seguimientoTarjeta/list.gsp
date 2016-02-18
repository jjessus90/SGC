

<!DOCTYPE html>
<html>
	<head>
		<meta name="layout" content="main">
		<g:set var="entityName" value="${message(code: 'seguimientoTarjeta.label', default: 'SeguimientoTarjeta')}" />
		<title><g:message code="default.list.label" args="[entityName]" /></title>
	</head>
	<body>
		<a href="#list-seguimientoTarjeta" class="skip" tabindex="-1"><g:message code="default.link.skip.label" default="Skip to content&hellip;"/></a>
		<div class="nav" role="navigation">
			<ul>
				<li><a class="home" href="${createLink(uri: '/')}"><g:message code="default.home.label"/></a></li>
				<li><g:link class="create" action="create"><g:message code="default.new.label" args="[entityName]" /></g:link></li>
			</ul>
		</div>
		<div id="list-seguimientoTarjeta" class="content scaffold-list" role="main">
			<h1><g:message code="default.list.label" args="[entityName]" /></h1>
			<g:if test="${flash.message}">
			<div class="message" role="status">${flash.message}</div>
			</g:if>
			<table>
				<thead>
					<tr>
					
						<th><g:message code="seguimientoTarjeta.tarjetaInformativa.label" default="Tarjeta Informativa" /></th>
					
						<g:sortableColumn property="fechaCaptura" title="${message(code: 'seguimientoTarjeta.fechaCaptura.label', default: 'Fecha Captura')}" />
					
						<g:sortableColumn property="seguimiento" title="${message(code: 'seguimientoTarjeta.seguimiento.label', default: 'Seguimiento')}" />
					
						<th><g:message code="seguimientoTarjeta.usuarioSistema.label" default="Usuario Sistema" /></th>
					
					</tr>
				</thead>
				<tbody>
				<g:each in="${seguimientoTarjetaInstanceList}" status="i" var="seguimientoTarjetaInstance">
					<tr class="${(i % 2) == 0 ? 'even' : 'odd'}">
					
						<td><g:link action="show" id="${seguimientoTarjetaInstance.id}">${fieldValue(bean: seguimientoTarjetaInstance, field: "tarjetaInformativa")}</g:link></td>
					
						<td><g:formatDate date="${seguimientoTarjetaInstance.fechaCaptura}" /></td>
					
						<td>${fieldValue(bean: seguimientoTarjetaInstance, field: "seguimiento")}</td>
					
						<td>${fieldValue(bean: seguimientoTarjetaInstance, field: "usuarioSistema")}</td>
					
					</tr>
				</g:each>
				</tbody>
			</table>
			<div class="pagination">
				<g:paginate total="${seguimientoTarjetaInstanceTotal}" />
			</div>
		</div>
	</body>
</html>
