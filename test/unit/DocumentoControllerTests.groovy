

import org.junit.*
import grails.test.mixin.*

@TestFor(DocumentoController)
@Mock(Documento)
class DocumentoControllerTests {

    def populateValidParams(params) {
        assert params != null
        // TODO: Populate valid properties like...
        //params["name"] = 'someValidName'
    }

    void testIndex() {
        controller.index()
        assert "/documento/list" == response.redirectedUrl
    }

    void testList() {

        def model = controller.list()

        assert model.documentoInstanceList.size() == 0
        assert model.documentoInstanceTotal == 0
    }

    void testCreate() {
        def model = controller.create()

        assert model.documentoInstance != null
    }

    void testSave() {
        controller.save()

        assert model.documentoInstance != null
        assert view == '/documento/create'

        response.reset()

        populateValidParams(params)
        controller.save()

        assert response.redirectedUrl == '/documento/show/1'
        assert controller.flash.message != null
        assert Documento.count() == 1
    }

    void testShow() {
        controller.show()

        assert flash.message != null
        assert response.redirectedUrl == '/documento/list'

        populateValidParams(params)
        def documento = new Documento(params)

        assert documento.save() != null

        params.id = documento.id

        def model = controller.show()

        assert model.documentoInstance == documento
    }

    void testEdit() {
        controller.edit()

        assert flash.message != null
        assert response.redirectedUrl == '/documento/list'

        populateValidParams(params)
        def documento = new Documento(params)

        assert documento.save() != null

        params.id = documento.id

        def model = controller.edit()

        assert model.documentoInstance == documento
    }

    void testUpdate() {
        controller.update()

        assert flash.message != null
        assert response.redirectedUrl == '/documento/list'

        response.reset()

        populateValidParams(params)
        def documento = new Documento(params)

        assert documento.save() != null

        // test invalid parameters in update
        params.id = documento.id
        //TODO: add invalid values to params object

        controller.update()

        assert view == "/documento/edit"
        assert model.documentoInstance != null

        documento.clearErrors()

        populateValidParams(params)
        controller.update()

        assert response.redirectedUrl == "/documento/show/$documento.id"
        assert flash.message != null

        //test outdated version number
        response.reset()
        documento.clearErrors()

        populateValidParams(params)
        params.id = documento.id
        params.version = -1
        controller.update()

        assert view == "/documento/edit"
        assert model.documentoInstance != null
        assert model.documentoInstance.errors.getFieldError('version')
        assert flash.message != null
    }

    void testDelete() {
        controller.delete()
        assert flash.message != null
        assert response.redirectedUrl == '/documento/list'

        response.reset()

        populateValidParams(params)
        def documento = new Documento(params)

        assert documento.save() != null
        assert Documento.count() == 1

        params.id = documento.id

        controller.delete()

        assert Documento.count() == 0
        assert Documento.get(documento.id) == null
        assert response.redirectedUrl == '/documento/list'
    }
}
