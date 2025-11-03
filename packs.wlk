// completar
//Paquetes
class Pack {
    var duracionEnDias
    var precioBase
    const beneficiosEspeciales = #{}
    var coordinadorACargo

    method beneficiosVigentes() = beneficiosEspeciales.filter({b => b.estaVigente()})
    method costoFinal() = precioBase + self.beneficiosVigentes().sum({b => b.costo()})
    method agregarBeneficio(unBeneficio) {
        beneficiosEspeciales.add(unBeneficio)
    }
    method beneficiosEspeciales() = beneficiosEspeciales
    method esPremium()
}
class PackNacional inherits Pack{
    var property provinciaDestino
    const property actividadesIncluidas = #{} 

    override method esPremium() = (duracionEnDias > 10) && coordinadorACargo.esAltamenteCalificado()
}

class PackProvincial inherits PackNacional {
    var cantidadDeCiudadesAVisitar

    override method esPremium() = self.actividadesIncluidas().size() >= 4 && cantidadDeCiudadesAVisitar > 5 && self.beneficiosVigentes().size() >= 3
    override method costoFinal() = super() * 1.05  //Aumenta un 5% sobre el costo final
}

class PackInternacional inherits Pack{
    var property paisDestino
    var property cantidadEscalas
    var property esDeInteresTuristico

    override method costoFinal() = super() * 1.2  //Aumenta un 20% sobre el costo final
    override method esPremium() = esDeInteresTuristico && duracionEnDias > 20 && cantidadEscalas == 0
}

//Coordinadores
class Coordinador {
    var cantidadViajesRealizados
    var estaMotivado
    var aniosDeExperiencia
    var rolAsignado  //puede ser guia, asistente, acompaniante
    const property rolesValidos = #{guia, asistente, acompaniante}

    method rolAsignado() = rolAsignado
    method cambiarRol(unRol) {
        if (!rolesValidos.contains(unRol)) {
            throw new Exception (message = "Rol inválido.")
        }
        rolAsignado = unRol
    }
    method estaMotivado() = estaMotivado
    method aniosDeExperiencia() = aniosDeExperiencia    
    method esAltamenteCalificado() = cantidadViajesRealizados > 20 && rolAsignado.condicionAdicional(self)
}

object guia {
  method condicionAdicional(unCoordinador) = unCoordinador.estaMotivado()
}

object asistente {
  method condicionAdicional(unCoordinador) = unCoordinador.aniosDeExperiencia() >= 3
}
object acompaniante {
  method condicionAdicional(unCoordinador) = true
}

//Beneficios Especiales
class Beneficio { //definidos como texto. Traslados privados, acceso a salas VIP y seguros adicionales.
    const tipo 
    var costo
    var estaVigente

    method estaVigente() = estaVigente
    method costo() = costo
}