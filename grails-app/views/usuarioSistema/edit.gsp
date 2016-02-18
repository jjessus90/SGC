


<html>
  <head>
    <meta http-equiv="Content-Type" content="text/html; charset=UTF-8" />
    <meta name="layout" content="main" />
  <g:set var="entityName" value="${message(code: 'usuarioSistema.label', default: 'UsuarioSistema')}" />
  <title><g:message code="default.edit.label" args="[entityName]" /></title>
  
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
    <g:hasErrors bean="${usuarioSistemaInstance}">
      <div class="errors">
        <g:renderErrors bean="${usuarioSistemaInstance}" as="list" />
      </div>
    </g:hasErrors>
    <g:form method="post" >
      <g:hiddenField name="id" value="${usuarioSistemaInstance?.id}" />
      <g:hiddenField name="version" value="${usuarioSistemaInstance?.version}" />
      
        <table>
          <tbody>
          
<div id="tabs">
  <ul>
    <li><a href="#tabs-1">Editar Usuario</a></li>
    
  </ul>
    <div id="tabs-1">

          <tr class="prop">
            <td valign="top" class="name">
              <label for="username"><g:message code="usuarioSistema.username.label" default="Username" /></label>
            </td>
            <td valign="top" class="value ${hasErrors(bean: usuarioSistemaInstance, field: 'username', 'errors')}">
          <g:textField name="username" value="${usuarioSistemaInstance?.username}" />
          </td>
          </tr>

          <tr class="prop">
            <td valign="top" class="name">
              <label for="nombreCompleto"><g:message code="usuarioSistema.nombreCompleto.label" default="Nombre Completo" /></label>
            </td>
            <td valign="top" class="value ${hasErrors(bean: usuarioSistemaInstance, field: 'nombreCompleto', 'errors')}">
          <g:textField name="nombreCompleto" value="${usuarioSistemaInstance?.nombreCompleto}" />
          </td>
          </tr>

          <tr class="prop">
            <td valign="top" class="name">
              <label for="passwd"><g:message code="usuarioSistema.passwd.label" default="Passwd" /></label>
            </td>
            <td valign="top" class="value ${hasErrors(bean: usuarioSistemaInstance, field: 'passwd', 'errors')}">
          <g:passwordField name="passwd" value="${usuarioSistemaInstance?.passwd}" />
          </td>
          </tr>
          
          <tr><td>
          
            <label for="dependencia">
              <g:message code="documento.dependencia.label" default="Dependencia:" />
              <span class="required-indicator"></span>
            </label></td>
            <td>
            <g:select id="dependencia" name="dependencia.id" from="${Dependencia.list()}" optionKey="id" required="" value="${usuarioSistemaInstance?.dependencia?.id}" class="many-to-one"/>
          </td></tr>

          <tr class="prop">
            <td valign="top" class="name">
              <label for="enabled"><g:message code="usuarioSistema.enabled.label" default="Activo" /></label>
            </td>
            <td valign="top" class="value ${hasErrors(bean: usuarioSistemaInstance, field: 'enabled', 'errors')}">
          <g:checkBox name="enabled" value="${usuarioSistemaInstance?.enabled}" />
          </td>
          </tr>

          <tr class="prop">
            <td valign="top" class="name">
              <label for="authorities"><g:message code="usuarioSistema.authorities.label" default="Authorities" /></label>
            </td>
            <td valign="top" class="value ${hasErrors(bean: usuarioSistemaInstance, field: 'authorities', 'errors')}">

            </td>
          </tr>

          <tr class="prop">
            <td valign="top" class="name">
              <label for="email"><g:message code="usuarioSistema.email.label" default="Email" /></label>
            </td>
            <td valign="top" class="value ${hasErrors(bean: usuarioSistemaInstance, field: 'email', 'errors')}">
          <g:textField name="email" value="${usuarioSistemaInstance?.email}" />
          </td>
          </tr>


          <tr class="prop">
            <td valign="top" class="name"><label for="authorities">Asignar Roles:</label></td>
            <td valign="top" class="value ${hasErrors(bean:person,field:'authorities','errors')}">
              <ul>
                <g:each var="entry" in="${roleMap}">
                  <li>${entry.key.authority.encodeAsHTML()}
                  <g:checkBox name="${entry.key.authority}" value="${entry.value}"/>
                  </li>
                </g:each>
              </ul>
            </td>
          </tr>

          </tbody>
        </table>
      </div></div>
      <div class="buttons">
        <span class="button"><g:actionSubmit class="save" action="update" value="${message(code: 'default.button.update.label', default: 'Update')}" /></span>
        <!--<span class="button"><g:actionSubmit class="delete" action="delete" value="${message(code: 'default.button.delete.label', default: 'Delete')}" onclick="return confirm('${message(code: 'default.button.delete.confirm.message', default: 'Are you sure?')}');" /></span>-->
      </div>
    </g:form>
  </sec:ifAllGranted>
  <!--  TERMINA ----- ADMINISTRADOR -->
    
    <sec:ifNotGranted roles="ROLE_ADMINISTRADOR">
		No estas autorizado...
	</sec:ifNotGranted>
</body>
</html>
