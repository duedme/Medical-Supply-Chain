library data_structures;

/// @notice Se guarda el estado actual de una medicina.
/// Datos generales.
pub struct Medicina_estado {
    caducidad: u8,
    numero_de_lote: u8,
    buen_estado: bool,
    empaque_seguro: bool,
}

/// @notice Registro de qué partes ya colaboraron al suministro.
/// Cada estado guarda un estado de medicina.
pub struct Suministro {
    fabricacion: Option<Medicina_estado>,
    distribucion: Option<Medicina_estado>,
    entrega: Option<Medicina_estado>,
    utilizacion: Option<Medicina_estado>,
}
