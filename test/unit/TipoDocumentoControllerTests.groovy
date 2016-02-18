

import org.junit.*
import grails.test.mixin.*

@TestFor(TipoDocumentoController)
@Mock(TipoDocumento)
class TipoDocumentoControllerTests {

    def populateValidParams(params) {
        assert params != null
        // TODO: Populate valid properties like...
        //params["name"] = 'someValidName'
    }

    void testIndex() {
        controller.index()
        assert "/tipoDocumento/list" == response.redirectedUrl
    }

    void testList() {

        def model = controller.list()

        assert model.tipoDocumentoInstanceList.size() == 0
        assert model.tipoDocumentoInstanceTotal == 0
    }

    void testCreate() {
        def model = controller.create()

        assert model.tipoDocumentoInstance != null
    }

    void testSave() {
        controller.save()

        assert model.tipoDocumentoInstance != null
        assert view == '/tipoDocumento/create'

        response.reset()

        populateValidParams(params)
        controller.save()

        assert response.redirectedUrl == '/tipoDocumento/show/1'
        assert controller.flash.message != null
        assert TipoDocumento.count() == 1
    }

    void testShow() {
        controller.show()

        assert flash.message != null
        assert response.redirectedUrl == '/tipoDocumento/list'

        populateValidParams(params)
        def tipoDocumento = new TipoDocumento(params)

        assert tipoDocumento.save() != null

        params.id = tipoDocumento.id

        def model = controller.show()

        assert model.tipoDocumentoInstance == tipoDocumento
    }

    void testEdit() {
        controller.edit()

        assert flash.message != null
        assert response.redirectedUrl == '/tipoDocumento/list'

        populateValidParams(params)
        def tipoDocumento = new TipoDocumento(params)

        assert tipoDocumento.save() != null

        params.id = tipoDocumento.id

        def model = controller.edit()

        assert model.tipoDocumentoInstance == tipoDocumento
    }

    void testUpdate() {
        controller.update()

        assert flash.message != null
        assert response.redirectedUrl == '/tipoDocumento/list'

        response.reset()

        populateValidParams(params)
        def tipoDocumento = new TipoDocumento(params)

        assert tipoDocumento.save() != null

        // test invalid parameters in update
        params.id = tipoDocumento.id
        //TODO: add invalid values to params object

        controller.update()

        assert view == "/tipoDocumento/edit"
        assert model.tipoDocumentoInstance != null

        tipoDocumento.clearErrors()

        populateValidParams(params)
        controller.update()

        assert response.redirectedUrl == "/tipoDocumento/show/$tipoDocumento.id"
        assert flash.message != null

        //test outdated version number
        response.reset()
        tipoDocumento.clearErrors()

        populateValidParams(params)
        params.id = tipoDocumento.id
        params.version = -1
        controller.update()

        assert view == "/tipoDocumento/edit"
        assert model.tipoDocumentoInstance != null
        assert model.tipoDocumentoInstance.errors.getFieldError('version')
        assert flash.message != null
    }

    void testDelete() {
        controller.delete()
        assert flash.message != null
        assert response.redirectedUrl == '/tipoDocumento/list'

        response.reset()

        populateValidParams(params)
        def tipoDocumento = new TipoDocumento(params)

        assert tipoDocumento.save() != null
        assert TipoDocumento.count() == 1

        params.id = tipoDocumento.id

        controller.delete()

        assert TipoDocumento.count() == 0
        assert TipoDocumento.get(tipoDocumento.id) == null
        assert response.redirectedUrl == '/tipoDocumento/list'
    }
}
