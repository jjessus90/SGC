

<!DOCTYPE html>
<html>
	<head>
		<meta name="layout" content="main">
		<g:set var="entityName" value="${message(code: 'clasificacionArchivo.label', default: 'ClasificacionArchivo')}" />
		<title><g:message code="default.show.label" args="[entityName]" /></title>
	</head>
	<body>
		<a href="#show-clasificacionArchivo" class="skip" tabindex="-1"><g:message code="default.link.skip.label" default="Skip to content&hellip;"/></a>
		<div class="nav" role="navigation">
			<ul>
				<li><a class="home" href="${createLink(uri: '/')}"><g:message code="default.home.label"/></a></li>
				<li><g:link class="list" action="list"><g:message code="default.list.label" args="[entityName]" /></g:link></li>
				<li><g:link class="create" action="create"><g:message code="default.new.label" args="[entityName]" /></g:link></li>
			</ul>
		</div>
		<div id="show-clasificacionArchivo" class="content scaffold-show" role="main">
			<h1><g:message code="default.show.label" args="[entityName]" /></h1>
			<g:if test="${flash.message}">
			<div class="message" role="status">${flash.message}</div>
			</g:if>
			<ol class="property-list clasificacionArchivo">
			
				<g:if test="${clasificacionArchivoInstance?.dependencia}">
				<li class="fieldcontain">
					<span id="dependencia-label" class="property-label"><g:message code="clasificacionArchivo.dependencia.label" default="Dependencia" /></span>
					
						<span class="property-value" aria-labelledby="dependencia-label"><g:fieldValue bean="${clasificacionArchivoInstance}" field="dependencia"/></span>
					
				</li>
				</g:if>
			
				<g:if test="${clasificacionArchivoInstance?.tipoDependencia}">
				<li class="fieldcontain">
					<span id="tipoDependencia-label" class="property-label"><g:message code="clasificacionArchivo.tipoDependencia.label" default="Tipo Dependencia" /></span>
					
						<span class="property-value" aria-labelledby="tipoDependencia-label"><g:fieldValue bean="${clasificacionArchivoInstance}" field="tipoDependencia"/></span>
					
				</li>
				</g:if>
			
				<g:if test="${clasificacionArchivoInstance?.clave}">
				<li class="fieldcontain">
					<span id="clave-label" class="property-label"><g:message code="clasificacionArchivo.clave.label" default="Clave" /></span>
					
						<span class="property-value" aria-labelledby="clave-label"><g:fieldValue bean="${clasificacionArchivoInstance}" field="clave"/></span>
					
				</li>
				</g:if>
			
				<g:if test="${clasificacionArchivoInstance?.anio}">
				<li class="fieldcontain">
					<span id="anio-label" class="property-label"><g:message code="clasificacionArchivo.anio.label" default="Año" /></span>
					
						<span class="property-value" aria-labelledby="anio-label"><g:formatDate date="${clasificacionArchivoInstance?.anio}" format="yyyy"/></span>
					
				</li>
				</g:if>
			
			</ol>
			<g:form>
				<fieldset class="buttons">
					<g:hiddenField name="id" value="${clasificacionArchivoInstance?.id}" />
					<g:link class="edit" action="edit" id="${clasificacionArchivoInstance?.id}"><g:message code="default.button.edit.label" default="Edit" /></g:link>
					<g:actionSubmit class="delete" action="delete" value="${message(code: 'default.button.delete.label', default: 'Delete')}" onclick="return confirm('${message(code: 'default.button.delete.confirm.message', default: 'Are you sure?')}');" />
				</fieldset>
			</g:form>
		</div>
	</body>
</html>
