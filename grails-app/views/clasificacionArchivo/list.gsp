

<!DOCTYPE html>
<html>
	<head>
		<meta name="layout" content="main">
		<g:set var="entityName" value="${message(code: 'clasificacionArchivo.label', default: 'ClasificacionArchivo')}" />
		<title><g:message code="default.list.label" args="[entityName]" /></title>
	</head>
	<body>
		<a href="#list-clasificacionArchivo" class="skip" tabindex="-1"><g:message code="default.link.skip.label" default="Skip to content&hellip;"/></a>
		<div class="nav" role="navigation">
			<ul>
				<li><a class="home" href="${createLink(uri: '/')}"><g:message code="default.home.label"/></a></li>
				<li><g:link class="create" action="create"><g:message code="default.new.label" args="[entityName]" /></g:link></li>
			</ul>
		</div>
		<div id="list-clasificacionArchivo" class="content scaffold-list" role="main">
			<h1><g:message code="default.list.label" args="[entityName]" /></h1>
			<g:if test="${flash.message}">
			<div class="message" role="status">${flash.message}</div>
			</g:if>
			<table>
				<thead>
					<tr>
					
						<g:sortableColumn property="dependencia" title="${message(code: 'clasificacionArchivo.dependencia.label', default: 'Dependencia')}" />
					
						<g:sortableColumn property="tipoDependencia" title="${message(code: 'clasificacionArchivo.tipoDependencia.label', default: 'Tipo Dependencia')}" />
					
						<g:sortableColumn property="clave" title="${message(code: 'clasificacionArchivo.clave.label', default: 'Clave')}" />
					
						<g:sortableColumn property="anio" title="${message(code: 'clasificacionArchivo.anio.label', default: 'Año')}" />
					
					</tr>
				</thead>
				<tbody>
				<g:each in="${clasificacionArchivoInstanceList}" status="i" var="clasificacionArchivoInstance">
					<tr class="${(i % 2) == 0 ? 'even' : 'odd'}">
					
						<td><g:link action="show" id="${clasificacionArchivoInstance.id}">${fieldValue(bean: clasificacionArchivoInstance, field: "dependencia")}</g:link></td>
					
						<td>${fieldValue(bean: clasificacionArchivoInstance, field: "tipoDependencia")}</td>
					
						<td>${fieldValue(bean: clasificacionArchivoInstance, field: "clave")}</td>
					
						<td><g:formatDate date="${clasificacionArchivoInstance.anio}" /></td>
					
					</tr>
				</g:each>
				</tbody>
			</table>
			<div class="pagination">
				<g:paginate total="${clasificacionArchivoInstanceTotal}" />
			</div>
		</div>
	</body>
</html>
