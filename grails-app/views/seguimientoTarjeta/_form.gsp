



<div class="fieldcontain ${hasErrors(bean: seguimientoTarjetaInstance, field: 'tarjetaInformativa', 'error')} required">
	<label for="tarjetaInformativa">
		<g:message code="seguimientoTarjeta.tarjetaInformativa.label" default="Tarjeta Informativa" />
		<span class="required-indicator">*</span>
	</label>
	<g:select id="tarjetaInformativa" name="tarjetaInformativa.id" from="${TarjetaInformativa.list()}" optionKey="id" required="" value="${seguimientoTarjetaInstance?.tarjetaInformativa?.id}" class="many-to-one"/>
</div>

<div class="fieldcontain ${hasErrors(bean: seguimientoTarjetaInstance, field: 'fechaCaptura', 'error')} required">
	<label for="fechaCaptura">
		<g:message code="seguimientoTarjeta.fechaCaptura.label" default="Fecha Captura" />
		<span class="required-indicator">*</span>
	</label>
	<g:datePicker name="fechaCaptura" precision="day"  value="${seguimientoTarjetaInstance?.fechaCaptura}"  />
</div>

<div class="fieldcontain ${hasErrors(bean: seguimientoTarjetaInstance, field: 'seguimiento', 'error')} ">
	<label for="seguimiento">
		<g:message code="seguimientoTarjeta.seguimiento.label" default="Seguimiento" />
		
	</label>
	<g:textField name="seguimiento" value="${seguimientoTarjetaInstance?.seguimiento}"/>
</div>

<div class="fieldcontain ${hasErrors(bean: seguimientoTarjetaInstance, field: 'usuarioSistema', 'error')} required">
	<label for="usuarioSistema">
		<g:message code="seguimientoTarjeta.usuarioSistema.label" default="Usuario Sistema" />
		<span class="required-indicator">*</span>
	</label>
	<g:select id="usuarioSistema" name="usuarioSistema.id" from="${UsuarioSistema.list()}" optionKey="id" required="" value="${seguimientoTarjetaInstance?.usuarioSistema?.id}" class="many-to-one"/>
</div>

