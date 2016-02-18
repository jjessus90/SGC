



<div class="fieldcontain ${hasErrors(bean: respuestaInstance, field: 'documento', 'error')} required">
	<label for="documento">
		<g:message code="respuesta.documento.label" default="Documento" />
		<span class="required-indicator">*</span>
	</label>
	<g:select id="documento" name="documento.id" from="${Documento.list()}" optionKey="id" required="" value="${respuestaInstance?.documento?.id}" class="many-to-one"/>
</div>

<div class="fieldcontain ${hasErrors(bean: respuestaInstance, field: 'fechaCaptura', 'error')} required">
	<label for="fechaCaptura">
		<g:message code="respuesta.fechaCaptura.label" default="Fecha Captura" />
		<span class="required-indicator">*</span>
	</label>
	<g:datePicker name="fechaCaptura" precision="day"  value="${respuestaInstance?.fechaCaptura}"  />
</div>

<div class="fieldcontain ${hasErrors(bean: respuestaInstance, field: 'respuesta', 'error')} ">
	<label for="respuesta">
		<g:message code="respuesta.respuesta.label" default="Respuesta" />
		
	</label>
	<g:textField name="respuesta" value="${respuestaInstance?.respuesta}"/>
</div>

<div class="fieldcontain ${hasErrors(bean: respuestaInstance, field: 'usuarioSistema', 'error')} required">
	<label for="usuarioSistema">
		<g:message code="respuesta.usuarioSistema.label" default="Usuario Sistema" />
		<span class="required-indicator">*</span>
	</label>
	<g:select id="usuarioSistema" name="usuarioSistema.id" from="${UsuarioSistema.list()}" optionKey="id" required="" value="${respuestaInstance?.usuarioSistema?.id}" class="many-to-one"/>
</div>

