# empresa-retail-admin

Configuración de seguridad para la base de datos **empresa_retail** (MySQL 8.0+), dividiendo las responsabilidades entre el personal de **Cajas**, **Inventario** y **Gerencia** mediante usuarios, roles y permisos con el principio de mínimo privilegio.

**Autores:** Kevin Leonel Coca Martínez y Peter Stiven Fernández Llantén — Ingeniería de Sistemas, Fundación Universitaria de Popayán

## Descripción del proyecto final

La empresa retail maneja información de clientes, canales de contacto, campañas de marketing, interacciones y conversiones (compras, registros y suscripciones). Cada área necesita acceder solo a la información que requiere para su trabajo. Este proyecto:

1. Define el modelo de datos de `empresa_retail` (5 tablas relacionadas).
2. Crea tres usuarios y tres roles, uno por área.
3. Aplica permisos granulares por tabla y por procedimiento almacenado.
4. Incluye procedimientos almacenados de solo consulta para el área de auditoría.
5. Verifica de forma automática que cada usuario pueda hacer únicamente lo permitido.

## Usuarios, roles y permisos

| Área | Usuario | Rol | Permisos |
|---|---|---|---|
| Cajas | `ana_crm` | `rol_ana` | Lectura y escritura (SELECT, INSERT, UPDATE) sobre `Clientes` e `Interacciones` |
| Inventario | `pedro_mkt` | `rol_pedro` | Lectura y escritura sobre `Canales` y `Campanias`; solo lectura (SELECT) sobre `Clientes` |
| Gerencia | `marta_auditoria` | `rol_marta` | SELECT sobre `Conversiones` y EXECUTE sobre los procedimientos de consulta |

Ningún rol tiene DELETE, DROP, ALTER ni GRANT OPTION. Las contraseñas están definidas en `sql/04_usuarios_roles.sql` según la guía de la actividad; **deben cambiarse en cualquier entorno real**.

## Estructura del repositorio

```
empresa-retail-admin/
├── README.md
├── .gitignore
├── sql/
│   ├── 01_esquema.sql
│   ├── 02_datos_prueba.sql
│   ├── 03_procedimientos_consulta.sql
│   ├── 04_usuarios_roles.sql
│   ├── 05_permisos.sql
│   └── 06_verificacion_privilegios.sql
└── docs/
    └── Informe_Tecnico_Empresa_Retail.docx
```

## Ramas

- `main`: versión estable (README y .gitignore).
- `develop`: solución completa de la actividad (scripts SQL, pruebas e informe técnico).
