contract;

dep data_structures;

use std::storage::StorageVec;

use data_structures::{Suministro,
    Suministro_constructor,
    Paciente,
    Medicina,
    Medicina_estado,
    Medicina_estado_constructor,
    Leer_informacion,
    Asignar_id_etapas_de_suministro,
    Asignar_id_usuario_paciente_y_medicina,
};

/// @notice Se inicializan todas las etapas del suministro a None (aún no ha empezado la distribucion).
/// @notice Se guardarán las direcciones de todos los elementos que intervinieron en la distribución.   
/// @notice Se guardará cada número de lote de medicinas.
/// @notice Se alojan también las medicinas utilizadas.
/// @notice A registrar los pacientes tratados con la medicina.
/// @notice Se toman en cuenta las direcciones de los entes por los que pasó el supply chain.
storage {
    suministro: Suministro = Suministro {
        fabricacion: Option::None,
        distribucion: Option::None,
        entrega: Option::None,
        utilizacion: Option::None,
        },

    numero_de_lote: u8 = 0,

    medicinas_segun_paciente: StorageVec<Medicina> = StorageVec{},

    paciente_aplicado: StorageVec<Paciente> = StorageVec{},

    id_fabricacion: b256 = 0x0000000000000000000000000000000000000000000000000000000000000000,
    id_distribucion: b256 = 0x0000000000000000000000000000000000000000000000000000000000000000,
    id_entrega: b256 = 0x0000000000000000000000000000000000000000000000000000000000000000,
    id_utilizacion: b256 = 0x0000000000000000000000000000000000000000000000000000000000000000,
}

/// @dev Se utiliza la función 'new_estado' de la estructura Medicina_estado.
impl Suministro_constructor for Contract {
    #[storage(write)]
    fn agregar_estado_en_fabricacion(caducidad: u8, buen_estado: bool, empaque_seguro: bool) {
        storage.suministro.fabricacion = Option::Some(
            Medicina_estado {
                caducidad,
                buen_estado,
                empaque_seguro,
            }
        );
    }

    #[storage(write)]
    fn agregar_estado_en_distribucion(caducidad: u8, buen_estado: bool, empaque_seguro: bool) {
        storage.suministro.distribucion = Option::Some(
            Medicina_estado {
                caducidad,
                buen_estado,
                empaque_seguro,
            }
        );
    }

    #[storage(write)]
    fn agregar_estado_en_entrega(caducidad: u8, buen_estado: bool, empaque_seguro: bool) {
        storage.suministro.entrega = Option::Some(
            Medicina_estado {
                caducidad,
                buen_estado,
                empaque_seguro,
            }
        );
    }

    #[storage(write)]
    fn agregar_estado_en_utilizacion(caducidad: u8, buen_estado: bool, empaque_seguro: bool) {
        storage.suministro.utilizacion = Option::Some(
            Medicina_estado {
                caducidad,
                buen_estado,
                empaque_seguro,
            }
        );
    }
}

/*impl Medicina_estado_constructor for Contract {
    fn new_estado(caducidad: u8, buen_estado: bool, empaque_seguro: bool,
    ) -> Medicina_estado {
        
        Medicina_estado {
            caducidad,
            buen_estado,
            empaque_seguro,
        }
    }
}*/

/// @notice Toda la información en storage para read_only.
impl Leer_informacion for Contract {
    #[storage(read)]
    fn sum() -> Suministro {
        storage.suministro
    }

    #[storage(read)]
    fn obtener_medicina(identificador_paciente: u8) -> Medicina {
        storage.paciente_aplicado.get(identificador_paciente).unwrap().medicina_aplicada
    }

   #[storage(read)]
    fn obtener_estado_fabrica() -> Medicina_estado {
        storage.suministro.fabricacion.unwrap()
    }

    #[storage(read)]
    fn obtener_estado_distribucion() -> Medicina_estado {
        storage.suministro.distribucion.unwrap()
    }
    
    #[storage(read)]
    fn obtener_estado_entrega() -> Medicina_estado {
        storage.suministro.entrega.unwrap()
    }
    
    #[storage(read)]
    fn obtener_estado_utilizacion() -> Medicina_estado {
        storage.suministro.utilizacion.unwrap()
    }

    #[storage(read)]
    fn obtener_caducidad(med: Medicina_estado) -> u8 {
        med.caducidad
    }

    #[storage(read)]
    fn obtener_buen_estado(med: Medicina_estado) -> bool {
        med.buen_estado
    }
    
    #[storage(read)]
    fn obtener_empaque_seguro(med: Medicina_estado) -> bool {
        med.empaque_seguro
    }

    #[storage(read)]
    fn obtener_id_fabricacion() -> b256 {
        storage.id_fabricacion
    }

    #[storage(read)]
    fn obtener_id_distribucion() -> b256 {
        storage.id_distribucion
    }
    
    #[storage(read)]
    fn obtener_id_entrega() -> b256 {
        storage.id_entrega
    }
    
    #[storage(read)]
    fn obtener_id_utilzacion() -> b256 {
        storage.id_utilizacion
    }
}

/// @notice Se registran las direcciones de los entes encargados de cada etapa de suministro.
impl Asignar_id_etapas_de_suministro for Contract {
    #[storage(write)]
    fn asignar_id_fabricacion(addr: b256) {
        storage.id_fabricacion = addr
    }

    #[storage(write)]
    fn asignar_id_distribucion(addr: b256) {
        storage.id_distribucion = addr
    }

    #[storage(write)]
    fn asignar_id_entrega(addr: b256) {
        storage.id_entrega = addr
    }

    #[storage(write)]
    fn asignar_id_utilizacion(addr: b256) {
        storage.id_utilizacion = addr
    }
}

/// @notice Con la primera función se registra en el contrato el número de lote de las medicinas.
/// @notice Con la segunda función se registra en cada medicina el número de lote en el contrato y
///     un identificador especial.
impl Asignar_id_usuario_paciente_y_medicina for Contract {
    #[storage(read, write)]   
    fn asignar_numero_de_lote() {
        storage.numero_de_lote = storage.numero_de_lote + 1
    }

    #[storage(read, write)]
    fn asignar_unidad_en_lote(max_number_of_units: u8) {
        let mut i = 0;
        while i < max_number_of_units {
            storage.medicinas_segun_paciente.push(
                Medicina {
                    numero_de_lote: storage.numero_de_lote,
                    unidad_aplicada: i,
                }
            );

            i += 1;
        }
    }
}