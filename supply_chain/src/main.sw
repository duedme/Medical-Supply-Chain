contract;


/// @notice Se guarda el estado actual de una medicina.
/// Datos generales.
struct Medicina_estado {
    caducidad: u8,
    numero_de_lote: u8,
    estado_correcto: bool,
}

/// @notice Registro de qué partes ya colaboraron al suministro.
/// Cada estado guarda un estado de medicina.
struct Suministro {
    fabricacion: Option<Medicina_estado>,
    distribucion: Option<Medicina_estado>,
    entrega: Option<Medicina_estado>,
    utilizacion: Option<Medicina_estado>,
}

storage {
    suministro: Suministro = Suministro { 
        fabricacion: Null,
        distribucion: Null,
        entrega: Null,
        utilizacion: Null,
        },
}