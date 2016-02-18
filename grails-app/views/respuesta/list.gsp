

<!DOCTYPE html>
<html>
	<head>
		<meta name="layout" content="main">
		<g:set var="entityName" value="${message(code: 'respuesta.label', default: 'Respuesta')}" />
		<title><g:message code="default.list.label" args="[entityName]" /></title>
	</head>
	<body>
		<a href="#list-respuesta" class="skip" tabindex="-1"><g:message code="default.link.skip.label" default="Skip to content&hellip;"/></a>
		<div class="nav" role="navigation">
			<ul>
				<li><a class="home" href="${createLink(uri: '/')}"><g:message code="default.home.label"/></a></li>
				<li><g:link class="create" action="create"><g:message code="default.new.label" args="[entityName]" /></g:link></li>
			</ul>
		</div>
		<div id="list-respuesta" class="content scaffold-list" role="main">
			<h1><g:message code="default.list.label" args="[entityName]" /></h1>
			<g:if test="${flash.message}">
			<div class="message" role="status">${flash.message}</div>
			</g:if>
			<table>
				<thead>
					<tr>
					
						<th><g:message code="respuesta.documento.label" default="Documento" /></th>
					
						<g:sortableColumn property="fechaCaptura" title="${message(code: 'respuesta.fechaCaptura.label', default: 'Fecha Captura')}" />
					
						<g:sortableColumn property="respuesta" title="${message(code: 'respuesta.respuesta.label', default: 'Respuesta')}" />
					
						<th><g:message code="respuesta.usuarioSistema.label" default="Usuario Sistema" /></th>
					
					</tr>
				</thead>
				<tbody>
				<g:each in="${respuestaInstanceList}" status="i" var="respuestaInstance">
					<tr class="${(i % 2) == 0 ? 'even' : 'odd'}">
					
						<td><g:link action="show" id="${respuestaInstance.id}">${fieldValue(bean: respuestaInstance, field: "documento")}</g:link></td>
					
						<td><g:formatDate date="${respuestaInstance.fechaCaptura}" /></td>
					
						<td>${fieldValue(bean: respuestaInstance, field: "respuesta")}</td>
					
						<td>${fieldValue(bean: respuestaInstance, field: "usuarioSistema")}</td>
					
					</tr>
				</g:each>
				</tbody>
			</table>
			<div class="pagination">
				<g:paginate total="${respuestaInstanceTotal}" />
			</div>
		</div>
	</body>
</html>
