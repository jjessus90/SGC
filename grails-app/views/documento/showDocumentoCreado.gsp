

<!DOCTYPE html>
<html>
  <head>
    <meta name="layout" content="main">
  <g:set var="entityName" value="${message(code: 'documento.label', default: 'Documento')}" />
  <title><g:message code="default.show.label" args="[entityName]" /></title>
</head>
<body>
  <a href="#show-documento" class="skip" tabindex="-1"><g:message code="default.link.skip.label" default="Skip to content&hellip;"/></a>
  <div class="nav" role="navigation">
    <ul>
      <li><a class="home" href="${createLink(uri: '/')}"><g:message code="default.home.label"/></a></li>
      <li><g:link class="list" action="list"><g:message code="default.list.label" args="[entityName]" /></g:link></li>
      <li><g:link class="create" action="create"><g:message code="default.new.label" args="[entityName]" /></g:link></li>
    </ul>
  </div>
  <div id="show-documento" class="content scaffold-show" role="main">
    <h1><g:message code="default.show.label" args="[entityName]" /></h1>
    <g:if test="${flash.message}">
      <div class="message" role="status">${flash.message}</div>
    </g:if>
    <ol class="property-list documento">

      <g:if test="${documentoInstance?.persona}">
        <li class="fieldcontain">
          <span id="remitente-label" class="property-label"><g:message code="documento.remitente.label" default="Remitente" /></span>

          <span class="property-value" aria-labelledby="remitente-label">${documentoInstance?.persona?.encodeAsHTML()}</span>

        </li>
      </g:if>

      <!--<g:if test="${documentoInstance?.prioridad}">
        <li class="fieldcontain">
          <span id="prioridad-label" class="property-label"><g:message code="documento.prioridad.label" default="Prioridad" /></span>

          <span class="property-value" aria-labelledby="prioridad-label"><g:fieldValue bean="${documentoInstance}" field="prioridad"/></span>

        </li>
      </g:if>-->
 <g:if test="${documentoInstance?.dependenciaRemitente}">
        <li class="fieldcontain">
          <span id="dependencia-label" class="property-label"><g:message code="documento.dependencia.label" default="Dependencia Remitente:" /></span>

          <span class="property-value" aria-labelledby="dependenciaRemitente-label">${documentoInstance?.dependenciaRemitente?.encodeAsHTML()}</span>

        </li>
      </g:if>
      
      <g:if test="${documentoInstance?.folio}">
        <li class="fieldcontain">
          <span id="folio-label" class="property-label"><g:message code="documento.folio.label" default="Folio" /></span>

          <span class="property-value" aria-labelledby="folio-label"><b><g:fieldValue bean="${documentoInstance}" field="folio"/></b></span>

        </li>
      </g:if>

      
     
      
      <g:if test="${documentoInstance?.asunto}">
        <li class="fieldcontain">
          <span id="asunto-label" class="property-label"><g:message code="documento.asunto.label" default="Asunto" /></span>

          <span class="property-value" aria-labelledby="asunto-label"><g:fieldValue bean="${documentoInstance}" field="asunto"/></span>

        </li>
      </g:if>

      <g:if test="${documentoInstance?.tipoDocumento}">
        <li class="fieldcontain">
          <span id="tipoDocumento-label" class="property-label"><g:message code="documento.tipoDocumento.label" default="Tipo Documento:" /></span>

          <span class="property-value" aria-labelledby="tipoDocumento-label">${documentoInstance?.tipoDocumento?.encodeAsHTML()}</span>

        </li>
      </g:if>
      
        
      <g:if test="${documentoInstance?.fechaCaptura}">
        <li class="fieldcontain">
          <span id="fechaSolicitud-label" class="property-label"><g:message code="documento.fechaCaptura.label" default="Fecha Captura" /></span>

          <span class="property-value" aria-labelledby="fechaCaptura-label"><g:formatDate date="${documentoInstance?.fechaCaptura}" format="yyyy-MM-dd"  /></span>

        </li>
      </g:if>
      <g:if test="${documentoInstance?.fechaRecibido}">
        <li class="fieldcontain">
          <span id="fechaSolicitud-label" class="property-label"><g:message code="documento.fechaRecibido.label" default="Fecha Recibido" /></span>

          <span class="property-value" aria-labelledby="fechaCaptura-label"><g:formatDate date="${documentoInstance?.fechaRecibido}" format="yyyy-MM-dd"  /></span>

        </li>
      </g:if>

    </ol>
    <g:form>
      <fieldset class="buttons">
        <g:hiddenField name="id" value="${documentoInstance?.id}" />
        <g:link class="edit" action="editDocumentoCreado" id="${documentoInstance?.id}">Editar</g:link>
        <g:actionSubmit class="delete" action="delete" value="${message(code: 'default.button.delete.label', default: 'Delete')}" onclick="return confirm('${message(code: 'default.button.delete.confirm.message', default: 'Are you sure?')}');" />
      </fieldset>
    </g:form>
  </div>
</body>
</html>
