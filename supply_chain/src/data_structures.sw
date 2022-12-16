library data_structures;

/// @notice Se registra el número de lote de cada medicina y su identificador numérico.
pub struct Medicina {
    numero_de_lote: u8,
    unidad_aplicada: u8,
}

/// @notice Se guarda el estado actual de una medicina.
/// Datos generales.
pub struct Medicina_estado {
    caducidad: u8,
    buen_estado: bool,
    empaque_seguro: bool,
}

/// @notice A los pacientes que se le aplicó la medicina se les asigna
///     un identificador y el medicamento específico que se le aplicó.
pub struct Paciente {
    identificador: u8,
    medicina_aplicada: Medicina,
}

/// @notice Registro de qué partes ya colaboraron a la cadena de suministro.
///     Cada estado guarda un estado de medicina.
pub struct Suministro {
    fabricacion: Option<Medicina_estado>,
    distribucion: Option<Medicina_estado>,
    entrega: Option<Medicina_estado>,
    utilizacion: Option<Medicina_estado>,
}

/// @notice A la cadena de suministro se le aplican métodos para indicar en qué estado se
///     encuentra (fabricación, distribución, entrega y utilización).
abi Suministro_constructor {
    #[storage(write)]
    fn agregar_estado_en_fabricacion(caducidad: u8, buen_estado: bool, empaque_seguro: bool);

    #[storage(write)]
    fn agregar_estado_en_distribucion(caducidad: u8, buen_estado: bool, empaque_seguro: bool);

    #[storage(write)]
    fn agregar_estado_en_entrega(caducidad: u8, buen_estado: bool, empaque_seguro: bool);

    #[storage(write)]
    fn agregar_estado_en_utilizacion(caducidad: u8, buen_estado: bool, empaque_seguro: bool);
}

/// @notice Constructor que dirá en que estado se encuentra una medicina.
abi Medicina_estado_constructor {
    fn new_estado(caducidad: u8, buen_estado: bool, empaque_seguro: bool,
    ) -> Medicina_estado;
}

/// @notice Se entregan todas las etapas de la cadena de suministro.
abi Leer_informacion {
    #[storage(read)]
    fn sum() -> Suministro;

    #[storage(read)]
    fn obtener_medicina(identificador_paciente: u8) -> Medicina;

    #[storage(read)]
    fn obtener_estado_fabrica() -> Medicina_estado;
    
    #[storage(read)]
    fn obtener_estado_distribucion() -> Medicina_estado;
    
    #[storage(read)]
    fn obtener_estado_entrega() -> Medicina_estado;
    
    #[storage(read)]
    fn obtener_estado_utilizacion() -> Medicina_estado;

    #[storage(read)]
    fn obtener_caducidad(med: Medicina_estado) -> u8;

    #[storage(read)]
    fn obtener_buen_estado(med: Medicina_estado) -> bool;
    
    #[storage(read)]
    fn obtener_empaque_seguro(med: Medicina_estado) -> bool;  

    #[storage(read)]
    fn obtener_id_fabricacion() -> b256;

    #[storage(read)]
    fn obtener_id_distribucion() -> b256;
    
    #[storage(read)]
    fn obtener_id_entrega() -> b256;
    
    #[storage(read)]
    fn obtener_id_utilzacion() -> b256;
}

/// @notice Se registran las direcciones de los entes encargados de cada etapa de suministro.
abi Asignar_id_etapas_de_suministro {
    #[storage(write)]
    fn asignar_id_fabricacion(addr: b256);

    #[storage(write)]
    fn asignar_id_distribucion(addr: b256);

    #[storage(write)]
    fn asignar_id_entrega(addr: b256);

    #[storage(write)]
    fn asignar_id_utilizacion(addr: b256);
}


/// @notice Con la primera función se registra en el contrato el número de lote de las medicinas.
/// @notice Con la segunda función se registra en cada medicina el número de lote en el contrato y
///     un identificador especial.
abi Asignar_id_usuario_paciente_y_medicina {
    #[storage(read, write)]   
    fn asignar_numero_de_lote();

    #[storage(read, write)]
    fn asignar_unidad_en_lote(max_number_of_units: u8);
}

/// @dev Función no implementada para reiniciar el contrato a vacío. Con excepción del número de lote
///     que aumentará cada vez que se utilice el contrato.
abi Reiniciar_contrato {
    #[storage(write)]
    fn reiniciar_contrato();
}