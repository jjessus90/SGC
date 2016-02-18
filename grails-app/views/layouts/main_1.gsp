<!doctype html>
<!--[if lt IE 7 ]> <html lang="en" class="no-js ie6"> <![endif]-->
<!--[if IE 7 ]>    <html lang="en" class="no-js ie7"> <![endif]-->
<!--[if IE 8 ]>    <html lang="en" class="no-js ie8"> <![endif]-->
<!--[if IE 9 ]>    <html lang="en" class="no-js ie9"> <![endif]-->
<!--[if (gt IE 9)|!(IE)]><!--> 
<html lang="en" class="no-js"><!--<![endif]-->
  <head>
    <link rel="shortcut icon" href="${resource(dir: 'images', file: 'favicon.ico')}" type="image/x-icon">
    <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge,chrome=1">
    <title>Correspondencia</title>
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <!--<link rel="apple-touch-icon" href="${resource(dir: 'images', file: 'apple-touch-icon.png')}">-->
    <!--  <link rel="apple-touch-icon" sizes="114x114" href="${resource(dir: 'images', file: 'apple-touch-icon-retina.png')}">-->
    <link rel="apple-touch-icon" href="${resource(dir: 'images', file: 'arrow.png')}">
    <link rel="apple-touch-icon" sizes="114x114" href="${resource(dir: 'images', file: 'arrow.png')}">
    <!--Bosstrap-->
    <!--<link rel="stylesheet" href="${resource(dir: 'css', file: 'bootstrap.min.css')}" type="text/css">-->
    <style>
      #lis
      {background:#fff url(../images/menu/arrow.gif) 245px 7px no-repeat;}
      #lis:hover  
      {background:#0C3344; color:#3f3f3f;}
    </style>



    <!-- Css Pagina -->
    <link rel="stylesheet" href="${resource(dir: 'css', file: 'main.css')}" type="text/css">
    <link rel="stylesheet" href="${resource(dir: 'css', file: 'mobile.css')}" type="text/css">
    <!--<link rel="stylesheet" href="${resource(dir: 'css', file: 'menuCss.css')}" type="text/css">-->
    <link rel="stylesheet" href="${resource(dir: 'css', file: 'menu.css')}" type="text/css">
    <link rel="stylesheet" href="${resource(dir: 'css', file: 'layout.css')}" type="text/css">

  <!--<g:javascript src="bootstrap.js" /> -->    
  <g:javascript src="bootstrap.min.js" />
  <!-- JQuery-->
  <link rel="stylesheet" href="${resource(dir: 'css', file: 'jquery-ui-1.10.3.custom.css')}" type="text/css">
  <g:javascript src="jquery-1.9.1.js" />
  <g:javascript src="jquery-ui-1.10.3.custom.js" />
  <g:javascript src="bootstrap.min.js" />

  <calendar:resources lang="en" theme="blue2"/>
  <g:layoutHead/>
  <r:layoutResources />
</head>
<body>
  <div id="grailsLogo" role="banner"> <div class="usuario" role="banner">  <!--<sec:loggedInUserInfo field="username"/>--></div></div>


<sec:ifNotLoggedIn> 
  <SCRIPT LANGUAGE="JavaScript">
           location.href='/SGC/login/auth';
  </SCRIPT>
</sec:ifNotLoggedIn>


<sec:ifLoggedIn> 

  <!-- ADMINISTRADOR -->
  <sec:ifAllGranted roles="ROLE_ADMINISTRADOR">



    <ul id="nav">
      <li><a href="${createLink(uri: '/')}"><img src="${resource(dir: 'images', file: 'home.png')}"/> Inicio</a></li>
      <li><a href="#"><span><img src="${resource(dir: 'images', file: 'top1.png')}"/> Usuarios</span></a>
        <div class="subs">
          <div class="col">
            <ul>

              <li><a href="#"><span><img src="${resource(dir: 'images', file: 'top1.png')}"/> Usuarios</span></a>
                <div class="subs">
                  <div class="col">
                    <ul>
                      <li><a href="${createLink(controller: 'UsuarioSistema',action:"create")}"><img src="${resource(dir: 'images', file: 'bub.png')}"/> Crear Usuario</a></li>
                      <li><a href="${createLink(controller: 'UsuarioSistema',action:"list")}"><img src="${resource(dir: 'images', file: 'bub.png')}"/> Lista de Usuarios</a></li>

                    </ul>
                  </div>

                </div>
              </li>

              <li><a href="#"><span><img src="${resource(dir: 'images', file: 'role.png')}"/> Roles</span></a>
                <div class="subs">
                  <div class="col">
                    <ul>

                      <li><a href="${createLink(controller: 'Role',action:"create")}"><img src="${resource(dir: 'images', file: 'bub.png')}"/> Crear Rol</a></li>
                      <li><a href="${createLink(controller: 'Role',action:"list")}"><img src="${resource(dir: 'images', file: 'bub.png')}"/> Lista de Roles</a></li>

                    </ul>
                  </div>

                </div>
              </li>
            </ul>
          </div>

        </div>
      </li>






      <li><a href="#"><span><img src="${resource(dir: 'images', file: 'catalog.png')}"/> Catálogos</span></a>
        <div class="subs">
          <div class="col">
            <ul>



              <li><a href="#"><span><img src="${resource(dir: 'images', file: 'dependency.png')}"/> Dependencia</span></a>
                <div class="subs">
                  <div class="col">
                    <ul>
                      <li><a href="${createLink(controller: 'Dependencia',action:"create")}"><img src="${resource(dir: 'images', file: 'bub.png')}"/> Crear Dependencia</a></li>
                      <li><a href="${createLink(controller: 'Dependencia',action:"list")}"><img src="${resource(dir: 'images', file: 'bub.png')}"/> Lista Dependencias</a></li>

                    </ul>
                  </div>

                </div>
              </li>

              <li><a href="#"><span><img src="${resource(dir: 'images', file: 'remitente.png')}"/> Remitente</span></a>
                <div class="subs">
                  <div class="col">
                    <ul>
                      <li><a href="${createLink(controller: 'Remitente',action:"create")}"><img src="${resource(dir: 'images', file: 'bub.png')}"/> Crear Remitente</a></li>
                      <li><a href="${createLink(controller: 'Remitente',action:"list")}"><img src="${resource(dir: 'images', file: 'bub.png')}"/> Lista Remitentes</a></li>

                    </ul>
                  </div>

                </div>
              </li>




              <li><a href="#"><span><img src="${resource(dir: 'images', file: 'indication.png')}"/> Indicación</span></a>
                <div class="subs">
                  <div class="col">
                    <ul>
                      <li><a href="${createLink(controller: 'Indicacion',action:"create")}"><img src="${resource(dir: 'images', file: 'bub.png')}"/> Crear Indicación</a></li>
                      <li><a href="${createLink(controller: 'Indicacion',action:"list")}"><img src="${resource(dir: 'images', file: 'bub.png')}"/> Lista Indicaciones</a></li>
                      
                    </ul>
                  </div>

                </div>
              </li>
              
              <li><a href="#"><span><img src="${resource(dir: 'images', file: 'tipoDoc.png')}"/> Tipo documento</span></a>
                <div class="subs">
                  <div class="col">
                    <ul>
                      <li><a href="${createLink(controller: 'TipoDocumento',action:"create")}"><img src="${resource(dir: 'images', file: 'bub.png')}"/> Crear Tipo Doc</a></li>
                      <li><a href="${createLink(controller: 'TipoDocumento',action:"list")}"><img src="${resource(dir: 'images', file: 'bub.png')}"/> Lista Tipo Doc</a></li>
                      
                    </ul>
                  </div>

                </div>
              </li>
              
            </ul>
          </div>

        </div>
      </li>

      <li><a href="#"><span><img src="${resource(dir: 'images', file: 'document.png')}"/> Documento</span></a>
        <div class="subs">
          <div class="col">
            <ul>

              <div class="col">
                <ul>
                  
                  <li><a href="${createLink(controller: 'Documento',action:"create")}"><img src="${resource(dir: 'images', file: 'bub.png')}"/> Crear Documento</a></li>
                      
                      <li><a href="${createLink(controller: 'Documento',action:"listaDocumentosCreados")}"><img src="${resource(dir: 'images', file: 'bub.png')}"/> Lista Docs. sin turnar</a></li>
                </ul>
              </div>


            </ul>
          </div>

        </div>
      </li>

      <li><a href="#"><span><img src="${resource(dir: 'images', file: 'find.png')}"/> Consultas</span></a>
        <div class="subs">
          <div class="col">
            <ul>

              <div class="col">
                <ul>
                  <li><a href="${createLink(controller: 'Documento',action:"list")}"><img src="${resource(dir: 'images', file: 'bub.png')}"/> Todos los Documentos</a></li>
                  <li><a href="${createLink(controller: 'Documento',action:"buscarDocPorFolio")}"><img src="${resource(dir: 'images', file: 'bub.png')}"/> Doc por folio</a></li>
                  <li><a href="${createLink(controller: 'Remitente',action:"list")}"><img src="${resource(dir: 'images', file: 'bub.png')}"/> Doc por remitente</a></li>
                  <li><a href="${createLink(controller: 'Documento',action:"buscarDocPorFecha")}"><img src="${resource(dir: 'images', file: 'bub.png')}"/> Doc por fecha</a></li>
                  <li><a href="${createLink(controller: 'Documento',action:"buscarDocPorDependencia")}"><img src="${resource(dir: 'images', file: 'bub.png')}"/> Doc por Dependencia</a></li>
                  <li><a href="${createLink(controller: 'Documento',action:"buscarDocEspecifico")}"><img src="${resource(dir: 'images', file: 'bub.png')}"/> Buscar Doc Especifico</a></li>
                  
                </ul>
              </div>


            </ul>
          </div>

        </div>
      </li>

      <li><a href="#"><span><img src="${resource(dir: 'images', file: 'reportPDF.png')}"/> Reportes</span></a>
        <div class="subs">
          <div class="col">
            <ul>

              <div class="col">
                <ul>
                  <li><a href="${createLink(controller: 'Reporte',action:"reporte")}"><img src="${resource(dir: 'images', file: 'reportPDF.png')}"/>Generar Doctos.</a></li>

                </ul>
              </div>


            </ul>
          </div>

        </div>
      </li>
      <li><a href="${createLink(controller: 'logout')}"><span><img src="${resource(dir: 'images', file: 'out.png')}"/> Salir</span></a>

      </li>








    </ul>
    <br>
    <br><br>




    

  </sec:ifAllGranted>
  <!-- ADMINISTRADOR -->

  
    <!-- INICIA --DEPENDENCIA -->
  <sec:ifAllGranted roles="ROLE_DEPENDENCIA">



    <ul id="nav">
      <li><a href="${createLink(uri: '/')}"><img src="${resource(dir: 'images', file: 'home.png')}"/> Inicio</a></li>
      
      <li><a href="#"><span><img src="${resource(dir: 'images', file: 'find.png')}"/> Consultas</span></a>
        <div class="subs">
          <div class="col">
            <ul>

              <div class="col">
                <ul>
                  <li><a href="${createLink(controller: 'Documento',action:"seguimientoDocDependencia")}"><img src="${resource(dir: 'images', file: 'bub.png')}"/> Docs sin Seguimiento</a></li>
                  <li><a href="${createLink(controller: 'Documento',action:"seguimientoDocDependenciaConsulta")}"><img src="${resource(dir: 'images', file: 'bub.png')}"/> Docs con seguimiento</a></li>
                </ul>
              </div>


            </ul>
          </div>

        </div>
      </li>

      <li><a href="${createLink(controller: 'logout')}"><span><img src="${resource(dir: 'images', file: 'out.png')}"/> Salir</span></a>

      </li>



    </ul>
    <br>
    <br><br>



  </sec:ifAllGranted>
  <!--  TERMINA ----- DEPENDENCIA -->

  
   <!-- INICIA -----RECEPCION -->
  <sec:ifAllGranted roles="ROLE_RECEPCION">



    <ul id="nav">
      <li><a href="${createLink(uri: '/')}"><img src="${resource(dir: 'images', file: 'home.png')}"/> Inicio</a></li>
      
      <li><a href="#"><span><img src="${resource(dir: 'images', file: 'catalog.png')}"/> Catálogos</span></a>
        <div class="subs">
          <div class="col">
            <ul>



              <li><a href="#"><span><img src="${resource(dir: 'images', file: 'dependency.png')}"/> Dependencia</span></a>
                <div class="subs">
                  <div class="col">
                    <ul>
                      <li><a href="${createLink(controller: 'Dependencia',action:"createDoc")}"><img src="${resource(dir: 'images', file: 'bub.png')}"/> Crear Dependencia</a></li>
                      <li><a href="${createLink(controller: 'Dependencia',action:"list")}"><img src="${resource(dir: 'images', file: 'bub.png')}"/> Lista Dependencias</a></li>

                    </ul>
                  </div>

                </div>
              </li>

              <li><a href="#"><span><img src="${resource(dir: 'images', file: 'remitente.png')}"/> Remitente</span></a>
                <div class="subs">
                  <div class="col">
                    <ul>
                      <li><a href="${createLink(controller: 'Remitente',action:"create")}"><img src="${resource(dir: 'images', file: 'bub.png')}"/> Crear Remitente</a></li>
                      <li><a href="${createLink(controller: 'Remitente',action:"list")}"><img src="${resource(dir: 'images', file: 'bub.png')}"/> Lista Remitentes</a></li>

                    </ul>
                  </div>

                </div>
              </li>

              
            </ul>
          </div>

        </div>
      </li>
      
      <li><a href="#"><span><img src="${resource(dir: 'images', file: 'document.png')}"/> Documento</span></a>
        <div class="subs">
          <div class="col">
            <ul>

              <div class="col">
                <ul>
                  
                  <li><a href="${createLink(controller: 'Documento',action:"create")}"><img src="${resource(dir: 'images', file: 'bub.png')}"/> Crear Documento</a></li>
                      
                      <li><a href="${createLink(controller: 'Documento',action:"listaDocumentosCreados")}"><img src="${resource(dir: 'images', file: 'bub.png')}"/> Lista Docs. sin turnar</a></li>
                </ul>
              </div>


            </ul>
          </div>

        </div>
      </li>
      
      
      
      <li><a href="#"><span><img src="${resource(dir: 'images', file: 'find.png')}"/> Consultas</span></a>
        <div class="subs">
          <div class="col">
            <ul>
              <div class="col">
                <ul>
                  <li><a href="${createLink(controller: 'Documento',action:"list")}"><img src="${resource(dir: 'images', file: 'bub.png')}"/> Todos los Documentos</a></li>
                  <li><a href="${createLink(controller: 'Documento',action:"buscarDocPorFolio")}"><img src="${resource(dir: 'images', file: 'bub.png')}"/> Doc por folio</a></li>
                  <li><a href="${createLink(controller: 'Remitente',action:"list")}"><img src="${resource(dir: 'images', file: 'bub.png')}"/> Doc por remitente</a></li>
                  <li><a href="${createLink(controller: 'Documento',action:"buscarDocPorFecha")}"><img src="${resource(dir: 'images', file: 'bub.png')}"/> Doc por fecha</a></li>
                  <li><a href="${createLink(controller: 'Documento',action:"buscarDocPorDependencia")}"><img src="${resource(dir: 'images', file: 'bub.png')}"/> Doc por Dependencia</a></li>
                  <li><a href="${createLink(controller: 'Documento',action:"buscarDocEspecifico")}"><img src="${resource(dir: 'images', file: 'bub.png')}"/> Buscar Doc Especifico</a></li>
                </ul>
              </div>
            </ul>
          </div>
        </div>
      </li>
      
      

      <li><a href="${createLink(controller: 'logout')}"><span><img src="${resource(dir: 'images', file: 'out.png')}"/> Salir</span></a>

      </li>



    </ul>
    <br>
    <br><br>



  </sec:ifAllGranted>
  <!--  TERMINA ----- DEPENDENCIA -->
  
  

  <g:set var="userObject" value="${UsuarioSistema.findByUsername(sec.loggedInUserInfo(field:'username'))}"/>
  <strong><font style="color: #0C3344">&nbsp&nbsp&nbsp&nbsp;SISTEMA PARA EL CONTROL DE CORRESPONDENCIA</font><br/> <font style="color: #0C3344"> &nbsp&nbsp&nbsp&nbsp;   Bienvenido: </strong>${userObject.nombreCompleto} </strong><img src="${resource(dir: 'images', file: 'us.png')}" width="20px" height="20px" />
<br/><br/>

</sec:ifLoggedIn> 


<g:layoutBody/>


<div class="footer" role="contentinfo"></div>
<div id="spinner" class="spinner" style="display:none;"><g:message code="spinner.alt" default="Loading&hellip;"/></div>
<g:javascript library="application"/>
<r:layoutResources />
</body>

</html>