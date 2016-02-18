

<!DOCTYPE html>
<html>
	<head>
		<meta name="layout" content="main">
		<g:set var="entityName" value="${message(code: 'turnado.label', default: 'Turnado')}" />
		<title><g:message code="default.list.label" args="[entityName]" /></title>
	</head>
	<body>
		<a href="#list-turnado" class="skip" tabindex="-1"><g:message code="default.link.skip.label" default="Skip to content&hellip;"/></a>
		<div class="nav" role="navigation">
			<ul>
				<li><a class="home" href="${createLink(uri: '/')}"><g:message code="default.home.label"/></a></li>
				<li><g:link class="create" action="create"><g:message code="default.new.label" args="[entityName]" /></g:link></li>
			</ul>
		</div>
		<div id="list-turnado" class="content scaffold-list" role="main">
			<h1><g:message code="default.list.label" args="[entityName]" /></h1>
			<g:if test="${flash.message}">
			<div class="message" role="status">${flash.message}</div>
			</g:if>
			<table>
				<thead>
					<tr>
					
						<th><g:message code="turnado.dependencia.label" default="Dependencia" /></th>
					
						<th><g:message code="turnado.usuarioSistema.label" default="Usuario Sistema" /></th>
					
						<th><g:message code="turnado.documento.label" default="Documento" /></th>
					
						<g:sortableColumn property="fechaTerminacion" title="${message(code: 'turnado.fechaTerminacion.label', default: 'Fecha Terminacion')}" />
					
						<g:sortableColumn property="fechaTurnado" title="${message(code: 'turnado.fechaTurnado.label', default: 'Fecha Turnado')}" />
					
					</tr>
				</thead>
				<tbody>
				<g:each in="${turnadoInstanceList}" status="i" var="turnadoInstance">
					<tr class="${(i % 2) == 0 ? 'even' : 'odd'}">
					
						<td>${fieldValue(bean: turnadoInstance, field: "dependencia")}</td>
					
						<td>${fieldValue(bean: turnadoInstance, field: "usuarioSistema")}</td>
					
						<td>${fieldValue(bean: turnadoInstance, field: "documento")}</td>
					
						<td><g:formatDate date="${turnadoInstance.fechaTerminacion}" /></td>
					
						<td><g:formatDate date="${turnadoInstance.fechaTurnado}" /></td>
					
					</tr>
				</g:each>
				</tbody>
			</table>
			<div class="pagination">
				<g:paginate total="${turnadoInstanceTotal}" />
			</div>
		</div>
	</body>
</html>
