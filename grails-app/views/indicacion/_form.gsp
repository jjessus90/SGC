<script>
/*Carga indicacion*/
  function cargaIndicacion(){

  $.ajax({
        url: '<%=request.getContextPath()%>'+'/documento/buscadorAjaxIndicaciones/',  
        method: 'GET',
  
        data:{id:document.getElementById('indicacion').value},
        success: function(objeto){             


  /**/
        if (objeto.length>0) {
  
            for (var i=0; i < objeto.length; i++) { 
                    var indica = objeto[i]; 
  
                    var text=indica.indicacion;
                    alert('valor'+text);
                    document.documento.indicacionTexto.value=text;
            }//fin for
        }else{
            document.documento.indicacionTexto.value='';
         }//fin else


         },
        failure: function(){
        alert('No se selecciono nada...');}

    });
  }
  </script>



<div class="fieldcontain ${hasErrors(bean: indicacionInstance, field: 'indicacion', 'error')} required">
	<label for="indicacion">
		<g:message code="indicacion.indicacion.label" default="Indicacion" />
		<span class="required-indicator">*</span>
	</label>
	<g:textArea name="indicacion" required="" value="${indicacionInstance?.indicacion}"/>
</div>



