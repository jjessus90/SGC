


<html>
  <head>
    <meta http-equiv="Content-Type" content="text/html; charset=UTF-8" />
    <meta name="layout" content="main" />
  <g:set var="entityName" value="${message(code: 'usuarioSistema.label', default: 'UsuarioSistema')}" />
  <title><g:message code="default.create.label" args="[entityName]" /></title>

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
  </div>



<g:if test="${flash.message}">
  <div class="message">${flash.message}</div>
</g:if>
<g:hasErrors bean="${usuarioSistemaInstance}">
  <div class="errors">
    <g:renderErrors bean="${usuarioSistemaInstance}" as="list" />
  </div>
</g:hasErrors>
<div id="tabs">
  <ul>
    <li><a href="#tabs-1">Crear Usuario</a></li>

  </ul>
  <div id="tabs-1">
    <g:form action="save" >
      <div class="dialog">
        <table>
          <tbody>



            <tr class="prop">
              <td valign="top" class="name">
                <label for="username"><g:message code="usuarioSistema.username.label" default="Username" /></label>
              </td>
              <td valign="top" class="value ${hasErrors(bean: usuarioSistemaInstance, field: 'username', 'errors')}">
          <g:textField name="username" required="true" value="${usuarioSistemaInstance?.username}" />
          </td>
          </tr>

          <tr class="prop">
            <td valign="top" class="name">
              <label for="nombreCompleto"><g:message code="usuarioSistema.nombreCompleto.label" default="Nombre Completo" /></label>
            </td>
            <td valign="top" class="value ${hasErrors(bean: usuarioSistemaInstance, field: 'nombreCompleto', 'errors')}">
          <g:textField name="nombreCompleto" required="" value="${usuarioSistemaInstance?.nombreCompleto}" />
          </td>
          </tr>

          <tr class="prop">
            <td valign="top" class="name">
              <label for="passwd"><g:message code="usuarioSistema.passwd.label" default="Password" /></label>
            </td>
            <td valign="top" class="value ${hasErrors(bean: usuarioSistemaInstance, field: 'passwd', 'errors')}">
          <g:passwordField name="passwd" required="" value="${usuarioSistemaInstance?.passwd}" />
          </td>
          </tr>
          
          
          
          <tr><td>
          
            <label for="dependencia">
              <g:message code="documento.dependencia.label" default="Dependencia:" />
              <span class="required-indicator"></span>
            </label></td>
            <td>
            <g:select id="dependencia" name="dependencia.id" required="" from="${listaDependencias}" optionKey="id" required="" value="${documentoInstance?.dependencia?.id}" class="many-to-one"/>
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
              <label for="email"><g:message code="usuarioSistema.email.label" default="Email" /></label>
            </td>
            <td valign="top" class="value ${hasErrors(bean: usuarioSistemaInstance, field: 'email', 'errors')}">
          <g:textField name="email" required="true" value="${usuarioSistemaInstance?.email}" />
          </td>
          </tr>

          <g:each in="${authorityList}">
            <tr>
              <td valign="top" class="name" align="left">${it.authority.encodeAsHTML()}</td>
              <td align="left"><g:checkBox name="${it.authority}"/></td>
            </tr>
          </g:each>

          </tbody>
        </table>
      </div>
      <div class="buttons">
        <span class="button"><g:submitButton name="create" class="save" value="${message(code: 'default.button.create.label', default: 'Create')}" /></span>
      </div>
    </g:form>
  </div>

</div>
 </sec:ifAllGranted>
  <!--  TERMINA ----- ADMINISTRADOR -->
    
    <sec:ifNotGranted roles="ROLE_ADMINISTRADOR">
		No estas autorizado...
	</sec:ifNotGranted>
    
</body>
</html>
