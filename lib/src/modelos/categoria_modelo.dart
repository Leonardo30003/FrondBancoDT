class Categoria {
  final int id;
  final String nombre_categoria;
  final String descripcion;
  final DateTime fecha_creacion;

  const Categoria({
    required this.id,
    required this.nombre_categoria,
    required this.descripcion,
    required this.fecha_creacion,
  });

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'nombre_categoria': nombre_categoria,
      'descripcion': descripcion,
      'fecha_creacion': fecha_creacion.toIso8601String(), // Convertir DateTime a String
    };
  }

  factory Categoria.fromJson(Map<String, dynamic> json) {
    return Categoria(
      id: json['id'],
      nombre_categoria: json['nombre_categoria'],
      descripcion: json['descripcion'],
      fecha_creacion: DateTime.parse(json['fecha_creacion']), // Parsear String a DateTime
    );
  }
}
