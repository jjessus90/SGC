

import org.junit.*
import grails.test.mixin.*

@TestFor(TarjetaInformativaController)
@Mock(TarjetaInformativa)
class TarjetaInformativaControllerTests {

    def populateValidParams(params) {
        assert params != null
        // TODO: Populate valid properties like...
        //params["name"] = 'someValidName'
    }

    void testIndex() {
        controller.index()
        assert "/tarjetaInformativa/list" == response.redirectedUrl
    }

    void testList() {

        def model = controller.list()

        assert model.tarjetaInformativaInstanceList.size() == 0
        assert model.tarjetaInformativaInstanceTotal == 0
    }

    void testCreate() {
        def model = controller.create()

        assert model.tarjetaInformativaInstance != null
    }

    void testSave() {
        controller.save()

        assert model.tarjetaInformativaInstance != null
        assert view == '/tarjetaInformativa/create'

        response.reset()

        populateValidParams(params)
        controller.save()

        assert response.redirectedUrl == '/tarjetaInformativa/show/1'
        assert controller.flash.message != null
        assert TarjetaInformativa.count() == 1
    }

    void testShow() {
        controller.show()

        assert flash.message != null
        assert response.redirectedUrl == '/tarjetaInformativa/list'

        populateValidParams(params)
        def tarjetaInformativa = new TarjetaInformativa(params)

        assert tarjetaInformativa.save() != null

        params.id = tarjetaInformativa.id

        def model = controller.show()

        assert model.tarjetaInformativaInstance == tarjetaInformativa
    }

    void testEdit() {
        controller.edit()

        assert flash.message != null
        assert response.redirectedUrl == '/tarjetaInformativa/list'

        populateValidParams(params)
        def tarjetaInformativa = new TarjetaInformativa(params)

        assert tarjetaInformativa.save() != null

        params.id = tarjetaInformativa.id

        def model = controller.edit()

        assert model.tarjetaInformativaInstance == tarjetaInformativa
    }

    void testUpdate() {
        controller.update()

        assert flash.message != null
        assert response.redirectedUrl == '/tarjetaInformativa/list'

        response.reset()

        populateValidParams(params)
        def tarjetaInformativa = new TarjetaInformativa(params)

        assert tarjetaInformativa.save() != null

        // test invalid parameters in update
        params.id = tarjetaInformativa.id
        //TODO: add invalid values to params object

        controller.update()

        assert view == "/tarjetaInformativa/edit"
        assert model.tarjetaInformativaInstance != null

        tarjetaInformativa.clearErrors()

        populateValidParams(params)
        controller.update()

        assert response.redirectedUrl == "/tarjetaInformativa/show/$tarjetaInformativa.id"
        assert flash.message != null

        //test outdated version number
        response.reset()
        tarjetaInformativa.clearErrors()

        populateValidParams(params)
        params.id = tarjetaInformativa.id
        params.version = -1
        controller.update()

        assert view == "/tarjetaInformativa/edit"
        assert model.tarjetaInformativaInstance != null
        assert model.tarjetaInformativaInstance.errors.getFieldError('version')
        assert flash.message != null
    }

    void testDelete() {
        controller.delete()
        assert flash.message != null
        assert response.redirectedUrl == '/tarjetaInformativa/list'

        response.reset()

        populateValidParams(params)
        def tarjetaInformativa = new TarjetaInformativa(params)

        assert tarjetaInformativa.save() != null
        assert TarjetaInformativa.count() == 1

        params.id = tarjetaInformativa.id

        controller.delete()

        assert TarjetaInformativa.count() == 0
        assert TarjetaInformativa.get(tarjetaInformativa.id) == null
        assert response.redirectedUrl == '/tarjetaInformativa/list'
    }
}
