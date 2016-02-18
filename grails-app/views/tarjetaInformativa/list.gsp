

<!DOCTYPE html>
<html>
	<head>
		<meta name="layout" content="main">
		<g:set var="entityName" value="${message(code: 'tarjetaInformativa.label', default: 'TarjetaInformativa')}" />
		<title><g:message code="default.list.label" args="[entityName]" /></title>
	</head>
	<body>
		<a href="#list-tarjetaInformativa" class="skip" tabindex="-1"><g:message code="default.link.skip.label" default="Skip to content&hellip;"/></a>
		<div class="nav" role="navigation">
			<ul>
				<li><a class="home" href="${createLink(uri: '/')}"><g:message code="default.home.label"/></a></li>
				<li><g:link class="create" action="create"><g:message code="default.new.label" args="[entityName]" /></g:link></li>
			</ul>
		</div>
		<div id="list-tarjetaInformativa" class="content scaffold-list" role="main">
			<h1><g:message code="default.list.label" args="[entityName]" /></h1>
			<g:if test="${flash.message}">
			<div class="message" role="status">${flash.message}</div>
			</g:if>
			<table>
				<thead>
					<tr>
					
						<g:sortableColumn property="numTarjeta" title="${message(code: 'tarjetaInformativa.numTarjeta.label', default: 'Num Tarjeta')}" />
					
						<g:sortableColumn property="asunto" title="${message(code: 'tarjetaInformativa.asunto.label', default: 'Asunto')}" />
					
						<th><g:message code="tarjetaInformativa.remitente.label" default="Remitente" /></th>
					
						<g:sortableColumn property="status" title="${message(code: 'tarjetaInformativa.status.label', default: 'Status')}" />
					
						<g:sortableColumn property="fechaCaptura" title="${message(code: 'tarjetaInformativa.fechaCaptura.label', default: 'Fecha Captura')}" />
					
					</tr>
				</thead>
				<tbody>
				<g:each in="${tarjetaInformativaInstanceList}" status="i" var="tarjetaInformativaInstance">
					<tr class="${(i % 2) == 0 ? 'even' : 'odd'}">
					
						<td><g:link action="show" id="${tarjetaInformativaInstance.id}">${fieldValue(bean: tarjetaInformativaInstance, field: "numTarjeta")}</g:link></td>
					
						<td>${fieldValue(bean: tarjetaInformativaInstance, field: "asunto")}</td>
					
						<td>${fieldValue(bean: tarjetaInformativaInstance, field: "remitente")}</td>
					
						<td>${fieldValue(bean: tarjetaInformativaInstance, field: "status")}</td>
					
						<td><g:formatDate date="${tarjetaInformativaInstance.fechaCaptura}" /></td>
					
					</tr>
				</g:each>
				</tbody>
			</table>
			<div class="pagination">
				<g:paginate total="${tarjetaInformativaInstanceTotal}" />
			</div>
		</div>
	</body>
</html>
