

<html>
  <head>
    <meta http-equiv="Content-Type" content="text/html; charset=UTF-8" />
    <meta name="layout" content="main" />
  <g:set var="entityName" value="${message(code: 'usuarioSistema.label', default: 'UsuarioSistema')}" />
  <title><g:message code="default.show.label" args="[entityName]" /></title>

  <script>
 $(function() {
   $( "#tabs" ).tabs();
 });
  </script>

</head>
<body>
     <!-- INICIA --ADMINISTRADOR -->
  <sec:ifAllGranted roles="ROLE_ADMINISTRADOR">
  <div class="nav">
    <span class="menuButton"><a class="home" href="${createLink(uri: '/')}"><g:message code="default.home.label"/></a></span>
    <span class="menuButton"><g:link class="list" action="list"><g:message code="default.list.label" args="[entityName]" /></g:link></span>
    <span class="menuButton"><g:link class="create" action="create"><g:message code="default.new.label" args="[entityName]" /></g:link></span>
  </div>


<g:if test="${flash.message}">
  <div class="message">${flash.message}</div>
</g:if>
<div id="tabs">
  <ul>
    <li><a href="#tabs-1">Mostrar Usuario</a></li>

  </ul>
  <div id="tabs-1">    

    <table>
      <tbody>


        <tr class="prop">
          <td valign="top" class="name"><g:message code="usuarioSistema.id.label" default="Id" /></td>

      <td valign="top" class="value">${fieldValue(bean: usuarioSistemaInstance, field: "id")}</td>

      </tr>

      <tr class="prop">
        <td valign="top" class="name"><g:message code="usuarioSistema.username.label" default="Username" /></td>

      <td valign="top" class="value">${fieldValue(bean: usuarioSistemaInstance, field: "username")}</td>

      </tr>

      <tr class="prop">
        <td valign="top" class="name"><g:message code="usuarioSistema.nombreCompleto.label" default="Nombre Completo" /></td>

      <td valign="top" class="value">${fieldValue(bean: usuarioSistemaInstance, field: "nombreCompleto")}</td>

      </tr>     


      <tr>
      <g:if test="${usuarioSistemaInstance?.dependencia}">
        <td>
          <span id="dependencia-label" class="property-label"><g:message code="documento.dependencia.label" default="Dependencia:" /></span>
        </td>
        <td>
          <span class="property-value" aria-labelledby="dependencia-label"><g:link controller="dependencia" action="show" id="${usuarioSistemaInstance?.dependencia?.id}">${usuarioSistemaInstance?.dependencia?.encodeAsHTML()}</g:link></span>
        </td>
      </g:if>
      </tr>

      <tr class="prop">
        <td valign="top" class="name"><g:message code="usuarioSistema.enabled.label" default="Activo" /></td>

      <td valign="top" class="value">
      <g:if test="${usuarioSistemaInstance.enabled}">
                                    <img src="${resource(dir:'images/skin',file:'arrow.png')}" height="20px" width="20px" />
                                    
                                    </g:if>
                                    <g:else>
                                       <img src="${resource(dir:'images/skin',file:'false.png')}" height="20px" width="20px" /> 
                                    </g:else>
      </td>

      </tr>

      <tr class="prop">
        <td valign="top" class="name"><g:message code="usuarioSistema.authorities.label" default="Authorities" /></td>

      <td valign="top" style="text-align: left;" class="value">
        <ul>
          <g:each in="${usuarioSistemaInstance.authorities}" var="a">
            <li><g:link controller="role" action="show" id="${a.id}">${a?.encodeAsHTML()}</g:link></li>
          </g:each>
        </ul>
      </td>

      </tr>

      <tr class="prop">
        <td valign="top" class="name"><g:message code="usuarioSistema.email.label" default="Email" /></td>

      <td valign="top" class="value">${fieldValue(bean: usuarioSistemaInstance, field: "email")}</td>

      </tr>



      <tr class="prop">
        <td valign="top" class="name">Roles:</td>
        <td valign="top" class="value">
          <ul>
            <g:each in="${roleNames}" var='name'>
              <li>${name}</li>
            </g:each>
          </ul>
        </td>
      </tr>

      </tbody>
    </table>
  </div></div>

<div class="buttons">
  <g:form>


    <g:hiddenField name="id" value="${usuarioSistemaInstance?.id}" />
    <span class="button"><g:actionSubmit class="edit" action="edit" value="${message(code: 'default.button.edit.label', default: 'Edit')}" /></span>
    <!--<span class="button"><g:actionSubmit class="delete" action="delete" value="${message(code: 'default.button.delete.label', default: 'Delete')}" onclick="return confirm('${message(code: 'default.button.delete.confirm.message', default: 'Are you sure?')}');" /></span>-->
  </g:form>
</div>
</sec:ifAllGranted>
  <!--  TERMINA ----- ADMINISTRADOR -->
    
    <sec:ifNotGranted roles="ROLE_ADMINISTRADOR">
		No estas autorizado...
	</sec:ifNotGranted>
</body>
</html>
