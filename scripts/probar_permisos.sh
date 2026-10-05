#!/usr/bin/env bash
DB=empresa_retail
ok=0; fail=0

run() {
  local user="$1" pass="$2" expected="$3" desc="$4" sql="$5" out result
  out=$(mysql -u"$user" -p"$pass" -D"$DB" -e "$sql" 2>&1)
  if echo "$out" | grep -q "ERROR 2002\|ERROR 1045\|ERROR 1049"; then
    result="ERROR_CONEXION"
  elif echo "$out" | grep -q "ERROR 1142\|ERROR 1370\|ERROR 1044\|ERROR 1143"; then
    result="DENEGADO"
  else
    result="OK"
  fi
  if [ "$result" = "$expected" ]; then status="PASA "; ok=$((ok+1)); else status="FALLA"; fail=$((fail+1)); fi
  printf "[%s] %-16s %-9s %s\n" "$status" "$user" "$result" "$desc"
}

A=ana_crm;  AP='Retail2026!Caja'
P=pedro_mkt; PP='Retail2026!Stock'
M=marta_auditoria; MP='Retail2026!Admin'

echo "== ana_crm (Cajas) =="
run $A "$AP" OK       "SELECT Clientes"            "SELECT * FROM Clientes LIMIT 1"
run $A "$AP" OK       "UPDATE Clientes"            "UPDATE Clientes SET ciudad='Popayán' WHERE id_cliente=1"
run $A "$AP" OK       "INSERT Interacciones"       "INSERT INTO Interacciones (id_cliente,id_canal,tipo,descripcion) VALUES (1,1,'Consulta','prueba')"
run $A "$AP" DENEGADO "DELETE Clientes"            "DELETE FROM Clientes WHERE id_cliente=999"
run $A "$AP" DENEGADO "SELECT Campanias"           "SELECT * FROM Campanias"
run $A "$AP" DENEGADO "SELECT Conversiones"        "SELECT * FROM Conversiones"

echo "== pedro_mkt (Inventario) =="
run $P "$PP" OK       "SELECT Clientes"            "SELECT * FROM Clientes LIMIT 1"
run $P "$PP" DENEGADO "UPDATE Clientes"            "UPDATE Clientes SET ciudad='X' WHERE id_cliente=1"
run $P "$PP" DENEGADO "INSERT Clientes"            "INSERT INTO Clientes (nombre,apellido,email) VALUES ('a','b','c@d.com')"
run $P "$PP" OK       "INSERT Canales"             "INSERT INTO Canales (nombre,descripcion) VALUES ('Prueba','temporal')"
run $P "$PP" OK       "UPDATE Campanias"           "UPDATE Campanias SET estado='Activa' WHERE id_campania=1"
run $P "$PP" DENEGADO "SELECT Interacciones"       "SELECT * FROM Interacciones"
run $P "$PP" DENEGADO "SELECT Conversiones"        "SELECT * FROM Conversiones"

echo "== marta_auditoria (Gerencia) =="
run $M "$MP" OK       "SELECT Conversiones"        "SELECT * FROM Conversiones"
run $M "$MP" OK       "CALL sp_resumen_conversiones" "CALL sp_resumen_conversiones()"
run $M "$MP" OK       "CALL sp_conversiones_por_tipo" "CALL sp_conversiones_por_tipo('Compra')"
run $M "$MP" OK       "CALL sp_conversiones_por_rango" "CALL sp_conversiones_por_rango('2026-03-01','2026-12-31')"
run $M "$MP" DENEGADO "SELECT Clientes"            "SELECT * FROM Clientes"
run $M "$MP" DENEGADO "INSERT Conversiones"        "INSERT INTO Conversiones (id_cliente,tipo) VALUES (1,'Compra')"
run $M "$MP" DENEGADO "UPDATE Conversiones"        "UPDATE Conversiones SET valor=1 WHERE id_conversion=1"

echo; echo "Resultado: $ok pruebas correctas, $fail fallidas"
[ "$fail" -eq 0 ]
