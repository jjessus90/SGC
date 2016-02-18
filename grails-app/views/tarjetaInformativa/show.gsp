

<!DOCTYPE html>
<html>
	<head>
		<meta name="layout" content="main">
		<g:set var="entityName" value="${message(code: 'tarjetaInformativa.label', default: 'TarjetaInformativa')}" />
		<title><g:message code="default.show.label" args="[entityName]" /></title>
		  <script>
            $(function() {
            $( "#tabs" ).tabs();
            });           
            
        </script>
	</head>
	<body>
		<a href="#show-tarjetaInformativa" class="skip" tabindex="-1"><g:message code="default.link.skip.label" default="Skip to content&hellip;"/></a>
		<div class="nav" role="navigation">
			<ul>
				<li><a class="home" href="${createLink(uri: '/')}"><g:message code="default.home.label"/></a></li>
				<li><g:link class="list" action="list"><g:message code="default.list.label" args="[entityName]" /></g:link></li>
				<li><g:link class="create" action="create"><g:message code="default.new.label" args="[entityName]" /></g:link></li>
			</ul>
		</div>
		<div id="show-tarjetaInformativa" class="content scaffold-show" role="main">
			<h1><g:message code="default.show.label" args="[entityName]" /></h1>
			<g:if test="${flash.message}">
			<div class="message" role="status">${flash.message}</div>
			</g:if>
			<ol class="property-list tarjetaInformativa">
			
				<g:if test="${tarjetaInformativaInstance?.numTarjeta}">
				<li class="fieldcontain">
					<span id="numTarjeta-label" class="property-label"><g:message code="tarjetaInformativa.numTarjeta.label" default="Num Tarjeta" /></span>
					
						<span class="property-value" aria-labelledby="numTarjeta-label"><g:fieldValue bean="${tarjetaInformativaInstance}" field="numTarjeta"/></span>
					
				</li>
				</g:if>
			
				<g:if test="${tarjetaInformativaInstance?.asunto}">
				<li class="fieldcontain">
					<span id="asunto-label" class="property-label"><g:message code="tarjetaInformativa.asunto.label" default="Asunto" /></span>
					
						<span class="property-value" aria-labelledby="asunto-label"><g:fieldValue bean="${tarjetaInformativaInstance}" field="asunto"/></span>
					
				</li>
				</g:if>
			
				<g:if test="${tarjetaInformativaInstance?.remitente}">
				<li class="fieldcontain">
					<span id="remitente-label" class="property-label"><g:message code="tarjetaInformativa.remitente.label" default="Remitente" /></span>
					
						<span class="property-value" aria-labelledby="remitente-label"><g:link controller="persona" action="show" id="${tarjetaInformativaInstance?.remitente?.id}">${tarjetaInformativaInstance?.remitente?.encodeAsHTML()}</g:link></span>
					
				</li>
				</g:if>
			
				<g:if test="${tarjetaInformativaInstance?.destinatiario}">
				<li class="fieldcontain">
					<span id="destinatiario-label" class="property-label"><g:message code="tarjetaInformativa.destinatiario.label" default="Destinatiario" /></span>
					
						<g:each in="${tarjetaInformativaInstance.destinatiario}" var="d">
						<span class="property-value" aria-labelledby="destinatiario-label"><g:link controller="turnadoTarjeta" action="show" id="${d.id}">${d?.persona?.nombre?.encodeAsHTML()}</g:link></span>
						</g:each>
					
				</li>
				</g:if>
			
				<g:if test="${tarjetaInformativaInstance?.fechaCaptura}">
				<li class="fieldcontain">
					<span id="fechaCaptura-label" class="property-label"><g:message code="tarjetaInformativa.fechaCaptura.label" default="Fecha Captura" /></span>
					
						<span class="property-value" aria-labelledby="fechaCaptura-label"><g:formatDate date="${tarjetaInformativaInstance?.fechaCaptura}" /></span>
					
				</li>
				</g:if>
			
				<g:if test="${tarjetaInformativaInstance?.seguimientos}">
				<li class="fieldcontain">
					<span id="seguimientos-label" class="property-label"><g:message code="tarjetaInformativa.seguimientos.label" default="Seguimientos" /></span>
					
						<g:each in="${tarjetaInformativaInstance.seguimientos}" var="s">
						<span class="property-value" aria-labelledby="seguimientos-label"><g:link controller="seguimientoTarjeta" action="show" id="${s.id}">${s?.encodeAsHTML()}</g:link></span>
						</g:each>
					
				</li>
				</g:if>
			
			</ol>
			<g:form>
				<fieldset class="buttons">
					<g:hiddenField name="id" value="${tarjetaInformativaInstance?.id}" />
					<g:link class="edit" action="edit" id="${tarjetaInformativaInstance?.id}"><g:message code="default.button.edit.label" default="Edit" /></g:link>
					<g:actionSubmit class="delete" action="delete" value="${message(code: 'default.button.delete.label', default: 'Delete')}" onclick="return confirm('${message(code: 'default.button.delete.confirm.message', default: 'Are you sure?')}');" />

					 <g:link class="save" action="agregarDependenciasNombre" controller="turnadoTarjeta" id="${tarjetaInformativaInstance?.id}">Agregar Turnado</g:link>
				</fieldset>
			</g:form>			
		</div>
		 <br>

            <div id="tabs">
                <ul>
                    <li><a href="#tabs-1">Turnado a:</a></li>
                    <li><a href="#tabs-2">Seguimiento</a></li>

                </ul>
                <div id="tabs-1">
                    <p>
                        <g:if test="${turnadoTarjetaInstance}">

                            <br>

                        <table style=" font-size: 13px;">
                            <thead>
                                <tr>

                                    <th>No.</th>

                                    <th>Dependencia</th>
                                    <th>Persona</th>
                                    

                                </tr>
                            </thead>
                            <tbody>
                                <g:each in="${turnadoTarjetaInstance}" status="i" var="turnado">
                                    <tr class="${(i % 2) == 0 ? 'even' : 'odd'}">


                                        <td>${i + 1} </td>

                                        <td>${turnadoTarjetaInstance[i]?.dependencia?.nombre?.encodeAsHTML()}</td>
                                        <td>${turnadoTarjetaInstance[i]?.persona?.nombre?.encodeAsHTML()}</td>

                                    </tr>
                                </g:each>
                            </tbody>

                        </table>
                    </g:if>
                    </p>
                </div>
                <div id="tabs-2">
                    <p>
                        <g:if test="${seguimientoInstance}">

                        <table style=" font-size: 13px;">
                            <thead>
                                <tr>

                                    <th>No.</th>
                                    <th>Seguimiento</th>
                                    <th>Fecha Captura</th>

                                </tr>
                            </thead>
                            <tbody>
                                <g:each in="${seguimientoInstance}" status="i" var="seguimiento">
                                    <tr class="${(i % 2) == 0 ? 'even' : 'odd'}">


                                        <td>${i + 1}</td>

                                        <td>${seguimientoInstance[i]?.seguimiento?.encodeAsHTML()}</td>

                                        <td>
                                            <g:formatDate date="${seguimientoInstance[i]?.fechaCaptura}" format="dd-MMM-yyyy" />
                                        </td>

                                    </tr>
                                </g:each>
                            </tbody>

                        </table>


                    </g:if>
                    </p>
                </div>
            </div>
                     <g:if test="${tarjetaInformativaInstance?.status==0}">
                        <span class="property-value" aria-labelledby="status-label"><h1>No se pueden generar reportes...</h1></span>
                    </g:if>
                    <g:elseif test="${tarjetaInformativaInstance?.status==1}">
                        <table>
                            <th>Nombre de Reporte</th>
                            <th>Generar Reporte</th>
                            <tr>
                                <td><h1>Crear Tarjeta Informativa</h1></td>
                             	<td><g:jasperReport jasper="tarjetaInformativa" format="PDF,PPTX" name="" action="tarjetaInformativa" controller="reporte">
 									<g:hiddenField name="idTarjeta" value="${tarjetaInformativaInstance?.id}" id="tarjetaInformativa" />
                                    <g:hiddenField name="asunto" value="${tarjetaInformativaInstance?.asunto}" />
                                    <g:hiddenField name="numTarjeta" value="${tarjetaInformativaInstance?.numTarjeta}" />
                                    <g:hiddenField name="fechaCaptura" value="${tarjetaInformativaInstance?.fechaCaptura}" />
                             	</td></g:jasperReport>
                            </tr>
                            </table>
                    </g:elseif>
              
        </div>
            
            
       
	</body>
</html>
