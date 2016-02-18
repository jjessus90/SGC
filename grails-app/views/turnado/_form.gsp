





<div class="fieldcontain ${hasErrors(bean: turnadoInstance, field: 'usuarioSistema', 'error')} required">
	<label for="usuarioSistema">
		<g:message code="turnado.usuarioSistema.label" default="Usuario Sistema" />
		<span class="required-indicator">*</span>
	</label>
	<g:select id="usuarioSistema" name="usuarioSistema.id" from="${UsuarioSistema.list()}" optionKey="id" required="" value="${turnadoInstance?.usuarioSistema?.id}" class="many-to-one"/>
</div>

<div class="fieldcontain ${hasErrors(bean: turnadoInstance, field: 'documento', 'error')} required">
	<label for="documento">
		<g:message code="turnado.documento.label" default="Documento" />
		<span class="required-indicator">*</span>
	</label>
	<g:select id="documento" name="documento.id" from="${Documento.list()}" optionKey="id" required="" value="${turnadoInstance?.documento?.id}" class="many-to-one"/>
</div>

<div class="fieldcontain ${hasErrors(bean: turnadoInstance, field: 'fechaTerminacion', 'error')} ">
	<label for="fechaTerminacion">
		<g:message code="turnado.fechaTerminacion.label" default="Fecha Terminacion" />
		
	</label>
	<g:datePicker name="fechaTerminacion" precision="day"  value="${turnadoInstance?.fechaTerminacion}" default="none" noSelection="['': '']" />
</div>
//////////ya esta
<div class="fieldcontain ${hasErrors(bean: turnadoInstance, field: 'fechaTurnado', 'error')} required">
	<label for="fechaTurnado">
		<g:message code="turnado.fechaTurnado.label" default="Fecha Turnado" />
		<span class="required-indicator">*</span>
	</label>
	<g:datePicker name="fechaTurnado" precision="day"  value="${turnadoInstance?.fechaTurnado}"  />
</div>

<div class="fieldcontain ${hasErrors(bean: turnadoInstance, field: 'fechaSeguimiento', 'error')} ">
	<label for="fechaSeguimiento">
		<g:message code="turnado.fechaSeguimiento.label" default="Fecha Seguimiento" />
		
	</label>
	<g:datePicker name="fechaSeguimiento" precision="day"  value="${turnadoInstance?.fechaSeguimiento}" default="none" noSelection="['': '']" />
</div>

<div class="fieldcontain ${hasErrors(bean: turnadoInstance, field: 'seguimiento', 'error')} ">
	<label for="seguimiento">
		<g:message code="turnado.seguimiento.label" default="Seguimiento" />
		
	</label>
	<g:textField name="seguimiento" value="${turnadoInstance?.seguimiento}"/>
</div>

<div class="fieldcontain ${hasErrors(bean: turnadoInstance, field: 'status', 'error')} ">
	<label for="status">
		<g:message code="turnado.status.label" default="Status" />
		
	</label>
	<g:checkBox name="status" value="${turnadoInstance?.status}" />
</div>

<div class="fieldcontain ${hasErrors(bean: turnadoInstance, field: 'dependencia', 'error')} required">
	<label for="dependencia">
		<g:message code="turnado.dependencia.label" default="Dependencia" />
		<span class="required-indicator">*</span>
	</label>
	<g:select id="dependencia" name="dependencia.id" from="${Dependencia.list()}" optionKey="id" required="" value="${turnadoInstance?.dependencia?.id}" class="many-to-one"/>
</div>

<div class="fieldcontain ${hasErrors(bean: turnadoInstance, field: 'unidadAdmin', 'error')} required">
	<label for="unidadAdmin">
		<g:message code="turnado.unidadAdmin.label" default="Unidad Admin" />
		<span class="required-indicator">*</span>
	</label>
	<g:select id="unidadAdmin" name="unidadAdmin.id" from="${UnidadAdmin.list()}" optionKey="id" required="" value="${turnadoInstance?.unidadAdmin?.id}" class="many-to-one"/>
</div>