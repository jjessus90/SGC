

<!DOCTYPE html>
<html>
	<head>
		<meta name="layout" content="main">
		<g:set var="entityName" value="${message(code: 'dependencia.label', default: 'Dependencia')}" />
		<title><g:message code="default.list.label" args="[entityName]" /></title>
	</head>
	<body>
		<a href="#list-dependencia" class="skip" tabindex="-1"><g:message code="default.link.skip.label" default="Skip to content&hellip;"/></a>
		<div class="nav" role="navigation">
			<ul>
				<li><a class="home" href="${createLink(uri: '/')}"><g:message code="default.home.label"/></a></li>
				<li><g:link class="create" action="create"><g:message code="default.new.label" args="[entityName]" /></g:link></li>
                                <li><a href="${createLink(controller:'Dependencia',action:"Dependencias")}">
                                <img src="${resource(dir: 'images', file:    'find.png')}"/>Buscar Dependencia</a></li>
			</ul>
		</div>
		<div id="list-dependencia" class="content scaffold-list" role="main">
			<h1><g:message code="default.list.label" args="[entityName]" /></h1>
			<g:if test="${flash.message}">
			<div class="message" role="status">${flash.message}</div>
			</g:if>
			<table>
				<thead>
					<tr>
					
						<g:sortableColumn property="nombre" title="${message(code: 'dependencia.nombre.label', default: 'Nombre')}" />
					
						<g:sortableColumn property="calleNumero" title="${message(code: 'dependencia.calleNumero.label', default: 'Calle Numero')}" />
					
						<g:sortableColumn property="status" title="${message(code: 'dependencia.status.label', default: 'Status')}" />
					
						<th><g:message code="dependencia.estado.label" default="Estado" /></th>
					
						<th><g:message code="dependencia.municipio.label" default="Municipio" /></th>
					
						<g:sortableColumn property="colonia" title="${message(code: 'dependencia.colonia.label', default: 'Colonia')}" />
					
					</tr>
				</thead>
				<tbody>
				<g:each in="${dependenciaInstanceList}" status="i" var="dependenciaInstance">
					<tr class="${(i % 2) == 0 ? 'even' : 'odd'}">
					
						<td><g:link action="show" id="${dependenciaInstance.id}">${fieldValue(bean: dependenciaInstance, field: "nombre")}</g:link></td>
					
						<td>${fieldValue(bean: dependenciaInstance, field: "calleNumero")}</td>
					
						<td><g:formatBoolean boolean="${dependenciaInstance.status}" /></td>
					
						<td>${fieldValue(bean: dependenciaInstance, field: "estado")}</td>
					
						<td>${fieldValue(bean: dependenciaInstance, field: "municipio")}</td>
					
						<td>${fieldValue(bean: dependenciaInstance, field: "colonia")}</td>
					
					</tr>
				</g:each>
				</tbody>
			</table>
			<div class="pagination">
				<g:paginate total="${dependenciaInstanceTotal}" />
			</div>
		</div>
	</body>
</html>
