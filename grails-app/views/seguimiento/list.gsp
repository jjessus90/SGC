

<!DOCTYPE html>
<html>
	<head>
		<meta name="layout" content="main">
		<g:set var="entityName" value="${message(code: 'seguimiento.label', default: 'Seguimiento')}" />
		<title><g:message code="default.list.label" args="[entityName]" /></title>
	</head>
	<body>
		<a href="#list-seguimiento" class="skip" tabindex="-1"><g:message code="default.link.skip.label" default="Skip to content&hellip;"/></a>
		<div class="nav" role="navigation">
			<ul>
				<li><a class="home" href="${createLink(uri: '/')}"><g:message code="default.home.label"/></a></li>
				<li><g:link class="create" action="create"><g:message code="default.new.label" args="[entityName]" /></g:link></li>
			</ul>
		</div>
		<div id="list-seguimiento" class="content scaffold-list" role="main">
			<h1><g:message code="default.list.label" args="[entityName]" /></h1>
			<g:if test="${flash.message}">
			<div class="message" role="status">${flash.message}</div>
			</g:if>
			<table>
				<thead>
					<tr>
					
						<th><g:message code="seguimiento.documento.label" default="Documento" /></th>
					
						<g:sortableColumn property="fechaCaptura" title="${message(code: 'seguimiento.fechaCaptura.label', default: 'Fecha Captura')}" />
					
						<g:sortableColumn property="seguimiento" title="${message(code: 'seguimiento.seguimiento.label', default: 'Seguimiento')}" />
					
					</tr>
				</thead>
				<tbody>
				<g:each in="${seguimientoInstanceList}" status="i" var="seguimientoInstance">
					<tr class="${(i % 2) == 0 ? 'even' : 'odd'}">
					
						<td><g:link action="show" id="${seguimientoInstance.id}">${fieldValue(bean: seguimientoInstance, field: "documento")}</g:link></td>
					
						<td><g:formatDate date="${seguimientoInstance.fechaCaptura}" /></td>
					
						<td>${fieldValue(bean: seguimientoInstance, field: "seguimiento")}</td>
					
					</tr>
				</g:each>
				</tbody>
			</table>
			<div class="pagination">
				<g:paginate total="${seguimientoInstanceTotal}" />
			</div>
		</div>
	</body>
</html>
