contract;

dep data_structures;

use data_structures::{Suministro, Medicina_estado};

storage {
    suministro: Suministro = Suministro { 
        fabricacion: Option::None,
        distribucion: Option::None,
        entrega: Option::None,
        utilizacion: Option::None,
        }
}

impl Suministro {
    #[storage(write)]
    fn agregar_estado_en_fabricacion(estado: Medicina_estado) {
        storage.suministro.fabricacion = Option::Some(estado);
    }

    #[storage(write)]
    fn agregar_estado_en_distribucion(estado: Medicina_estado) {
        storage.suministro.distribucion = Option::Some(estado);
    }

    #[storage(write)]
    fn agregar_estado_en_entrega(estado: Medicina_estado) {
        storage.suministro.entrega = Option::Some(estado);
    }

    #[storage(write)]
    fn agregar_estado_en_utilizacion(caducidad: u8, numero_de_lote: u8, buen_estado: bool, empaque_seguro: bool) {
        storage.suministro.utilizacion = Option::Some(Medicina_estado::new_estado(
            caducidad: u8,
            numero_de_lote: u8,
            buen_estado: bool,
            empaque_seguro: bool
        ))
    }
}

impl Medicina_estado {
    fn new_estado(
        caducidad: u8,
        numero_de_lote: u8,
        buen_estado: bool,
        empaque_seguro: bool,
    ) -> Medicina_estado {
        Medicina_estado {
            caducidad,
            numero_de_lote,
            buen_estado,
            empaque_seguro,
        }
    }
}
