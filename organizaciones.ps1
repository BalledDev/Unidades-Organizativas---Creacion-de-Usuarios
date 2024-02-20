# Creacion de ou principal elgaleon
New-ADOrganizationalUnit -Name "elgaleon" -Path "DC=ayose,DC=local"

# Creacion de ou Directivos
New-ADOrganizationalUnit -Name "Equipo_directivo" -Path "OU=elgaleon,DC=ayose,DC=local"

# Creacion de ou Administracion
New-ADOrganizationalUnit -Name "Personal_administrativo" -Path "OU=elgaleon,DC=ayose,DC=local"

# Creacion de ou Personal
New-ADOrganizationalUnit -Name "Personal_laboral" -Path "OU=elgaleon,DC=ayose,DC=local"

# Creacion de el ou Personal de limpieza y cafeteria dentro de la ou personal
New-ADOrganizationalUnit -Name "Personal_limpieza" -Path "OU=Personal_laboral,OU=elgaleon,DC=ayose,DC=local"
New-ADOrganizationalUnit -Name "Personal_cafeteria" -Path "OU=Personal_laboral,OU=elgaleon,DC=ayose,DC=local"

# Creacion de ou Profesorado
New-ADOrganizationalUnit -Name "Profesorado" -Path "OU=elgaleon,DC=ayose,DC=local"

# Creacion de ou Alumnado
New-ADOrganizationalUnit -Name "Alumnado" -Path "OU=elgaleon,DC=ayose,DC=local"

# Creacion de ou CLASES dentro de la ou Alumnado
New-ADOrganizationalUnit -Name "ESO" -Path "OU=Alumnado,OU=elgaleon,DC=ayose,DC=local"
New-ADOrganizationalUnit -Name "Bach" -Path "OU=Alumnado,OU=elgaleon,DC=ayose,DC=local"
New-ADOrganizationalUnit -Name "FP" -Path "OU=Alumnado,OU=elgaleon,DC=ayose,DC=local"

# Creacion de alumnos para la clase ESO
$letraClase = @("A","B","C","D","E","F","G","H")
# $alumnos = 30
$contrasena = "Alumnado"
$id = 1
$raiz = "ou=ESO,ou=Alumnado,ou=elgaleon,dc=ayose,dc=local"
$numeroClase = 4

for ($variable = 1; $variable -le $numeroClase; $variable++) {
    New-ADOrganizationalUnit -Name "${variable}ESO" -Path "${raiz}"

    for ($variable2 = 0; $variable2 -lt $letraClase.Length; $variable2++) {
        New-ADOrganizationalUnit -Name "${variable}$($letraClase[$variable2])" -Path "ou=${variable}ESO,${raiz}"

        New-ADGroup -Name "grupoESO${variable}$($letraClase[$variable2])" -SamAccountName "grupoESO${variable}$($letraClase[$variable2])" -GroupScope Global -GroupCategory Security -Path "ou=${variable}$($letraClase[$variable2]),ou=${variable}ESO,${raiz}"
        Start-Sleep -Seconds 1

        Write-Host "El grupoESO${variable}$($letraClase[$variable2]) ha sido creado correctamente" -ForegroundColor Green
        
        $groupDN = "cn=grupoESO${variable}$($letraClase[$variable2]),ou=${variable}$($letraClase[$variable2]),ou=${variable}ESO,${raiz}"
        while (-not (Get-ADGroup -Filter { DistinguishedName -eq $groupDN })) {
            Start-Sleep -Seconds 1
        }

        Write-Host "------------------ Creacion de Usuarios grupoESO${variable}$($letraClase[$variable2]) -------------------------" -ForegroundColor Red

        for ($variable3 = 1; $variable3 -le $alumnos; $variable3++) {
            
            $cial = "${variable}ESO$($letraClase[$variable2])${id}"

            New-ADUser -Name "alumno${cial}" -UserPrincipalName "alumno${cial}@ayose.local" -DisplayName "alumno${cial}" -Path "ou=${variable}$($letraClase[$variable2]),ou=${variable}ESO,${raiz}" -AccountPassword (ConvertTo-SecureString "$contrasena${cial}" -AsPlainText -Force)
            Add-ADGroupMember -Identity "grupoESO${variable}$($letraClase[$variable2])" -Members "alumno${cial}"

            Write-Host "El alumno${cial} ha sido creado correctamente"

            $id++
        }

        Write-Host "---------------- Alumnos grupoESO${variable}$($letraClase[$variable2]) creados correctamente ------------------" -ForegroundColor Red

        clear
    }
}

# Creacion de alumnos para la clase 1Bach
$letraClase = @("A","B","C","D")
# $alumnos = 30
$contrasena = "Alumnado"
$id = 1
$raiz = "ou=Bach,ou=Alumnado,ou=elgaleon,dc=ayose,dc=local"

New-ADOrganizationalUnit -Name "1Bach" -Path "${raiz}"

for ($variable2 = 0; $variable2 -lt $letraClase.Length; $variable2++) {
    New-ADOrganizationalUnit -Name "1$($letraClase[$variable2])" -Path "ou=1Bach,${raiz}"

    New-ADGroup -Name "grupo1Bach$($letraClase[$variable2])" -SamAccountName "grupo1Bach$($letraClase[$variable2])" -GroupScope Global -GroupCategory Security -Path "ou=1$($letraClase[$variable2]),ou=1Bach,${raiz}"
    Start-Sleep -Seconds 1

    Write-Host "El grupo1Bach$($letraClase[$variable2]) ha sido creado correctamente" -ForegroundColor Green

    $groupDN = "cn=grupo1Bach$($letraClase[$variable2]),ou=1$($letraClase[$variable2]),ou=1Bach,${raiz}"
    while (-not (Get-ADGroup -Filter { DistinguishedName -eq $groupDN })) {
        Start-Sleep -Seconds 1
    }

    Write-Host "------------------ Creacion de Usuarios grupo1Bach$($letraClase[$variable2]) -------------------------" -ForegroundColor Red

    for ($variable3 = 1; $variable3 -le $alumnos; $variable3++) {
        
        $cial = "1Bach$($letraClase[$variable2])${id}"

        New-ADUser -Name "alumno${cial}" -UserPrincipalName "alumno${cial}@ayose.local" -DisplayName "alumno${cial}" -Path "ou=1$($letraClase[$variable2]),ou=1Bach,${raiz}" -AccountPassword (ConvertTo-SecureString "$contrasena${cial}" -AsPlainText -Force)
        Add-ADGroupMember -Identity "grupo1Bach$($letraClase[$variable2])" -Members "alumno${cial}"

        Write-Host "El alumno${cial} ha sido creado correctamente"

        $id++
    }

    Write-Host "---------------- Alumnos grupo1Bach$($letraClase[$variable2]) creados correctamente ------------------" -ForegroundColor Red

    clear
}

# Creacion de alumnos para la clase CFPB
$letraClase = @("1CFPB","2CFPB")
# $alumnos = 30
$contrasena = "Alumnado"
$id = 1
$raiz = "ou=FP,ou=Alumnado,ou=elgaleon,dc=ayose,dc=local"

for ($variable2 = 0; $variable2 -lt $letraClase.Length; $variable2++) {
    New-ADOrganizationalUnit -Name "$($letraClase[$variable2])" -Path "${raiz}"

    New-ADGroup -Name "grupo$($letraClase[$variable2])" -SamAccountName "grupo$($letraClase[$variable2])" -GroupScope Global -GroupCategory Security -Path "ou=$($letraClase[$variable2]),${raiz}"
    Start-Sleep -Seconds 1

    Write-Host "El grupo$($letraClase[$variable2]) ha sido creado correctamente" -ForegroundColor Green

    $groupDN = "cn=grupo$($letraClase[$variable2]),ou=$($letraClase[$variable2]),${raiz}"
    while (-not (Get-ADGroup -Filter { DistinguishedName -eq $groupDN })) {
        Start-Sleep -Seconds 1
    }

    Write-Host "------------------ Creacion de Usuarios grupo$($letraClase[$variable2]) -------------------------" -ForegroundColor Red

    for ($variable3 = 1; $variable3 -le $alumnos; $variable3++) {

        $cial = "$($letraClase[$variable2])${id}"

        New-ADUser -Name "alumno${cial}" -UserPrincipalName "alumno${cial}@ayose.local" -DisplayName "alumno${cial}" -Path "ou=$($letraClase[$variable2]),${raiz}" -AccountPassword (ConvertTo-SecureString "$contrasena${cial}" -AsPlainText -Force)
        Add-ADGroupMember -Identity "grupo$($letraClase[$variable2])" -Members "alumno${cial}"
        
        Write-Host "El alumno${cial} ha sido creado correctamente"
        
        $id++
    }

    Write-Host "---------------- Alumnos grupo$($letraClase[$variable2]) creados correctamente ------------------" -ForegroundColor Red

    clear
}

# Creacion de alumnos para la clase CFGM
$letraClase = @("1CFGM","2CFGM")
# $alumnos = 30
$contrasena = "Alumnado"
$id = 1
$raiz = "ou=FP,ou=Alumnado,ou=elgaleon,dc=ayose,dc=local"

for ($variable2 = 0; $variable2 -lt $letraClase.Length; $variable2++) {
    New-ADOrganizationalUnit -Name "$($letraClase[$variable2])" -Path "${raiz}"

    New-ADGroup -Name "grupo$($letraClase[$variable2])" -SamAccountName "grupo$($letraClase[$variable2])" -GroupScope Global -GroupCategory Security -Path "ou=$($letraClase[$variable2]),${raiz}"
    Start-Sleep -Seconds 1

    Write-Host "El grupo$($letraClase[$variable2]) ha sido creado correctamente" -ForegroundColor Green

    $groupDN = "cn=grupo$($letraClase[$variable2]),ou=$($letraClase[$variable2]),${raiz}"
    while (-not (Get-ADGroup -Filter { DistinguishedName -eq $groupDN })) {
        Start-Sleep -Seconds 1
    }

    Write-Host "------------------ Creacion de Usuarios grupo$($letraClase[$variable2]) -------------------------" -ForegroundColor Red

    for ($variable3 = 1; $variable3 -le $alumnos; $variable3++) {

        $cial = "$($letraClase[$variable2])${id}"

        New-ADUser -Name "alumno${cial}" -UserPrincipalName "alumno${cial}@ayose.local" -DisplayName "alumno${cial}" -Path "ou=$($letraClase[$variable2]),${raiz}" -AccountPassword (ConvertTo-SecureString "$contrasena${cial}" -AsPlainText -Force)
        Add-ADGroupMember -Identity "grupo$($letraClase[$variable2])" -Members "alumno${cial}"

        Write-Host "El alumno${cial} ha sido creado correctamente"

        $id++
    }

    Write-Host "---------------- Alumnos grupo$($letraClase[$variable2]) creados correctamente ------------------" -ForegroundColor Red

    clear
}

# Creacion de profesores
$materias = @("dep_BG", "dep_EF", "dep_EPV", "dep_FI", "dep_FQ", "dep_FR", "dep_GH", "dep_INF", "dep_ING", "dep_LCL", "dep_MAT", "dep_MUS", "dep_ORI", "dep_REL", "dep_TEC", "dep_ECO")
$raiz = "ou=Profesorado,ou=elgaleon,dc=ayose,dc=local"
$cantidad = 6
$contrasena = "elgaleon_Profesorado"
$grupo = "grupoProfesorado_"
$id = 1


foreach ($key in $materias) {
    New-ADOrganizationalUnit -Name "$key" -Path "$raiz"
    New-ADGroup -Name "${grupo}${key}" -SamAccountName "${grupo}${key}" -GroupScope Global -GroupCategory Security -Path "ou=${key},${raiz}"

    Write-Host "El grupo ${grupo} ${key} ha sido creado correctamente" -ForegroundColor Green

    Write-Host "------------------ Creacion de Profesores asignatura ${key} -------------------------" -ForegroundColor Red

    for ($variable = 1; $variable -le $cantidad; $variable++) {
        New-ADUser -Name "Profesor_${key}${id}" -UserPrincipalName "Profesor_${key}${id}@ayose.local" -DisplayName "Profesor_${key}${id}" -Path "ou=${key},${raiz}" -AccountPassword (ConvertTo-SecureString "${contrasena}${id}" -AsPlainText -Force)
        Add-ADGroupMember -Identity "${grupo}${key}" -Members "Profesor_${key}${id}"

        Write-Host "El Profesor_${key}${id} ha sido creado correctamente"

        $id ++
    }

    Write-Host "---------------- Profesores asignatura ${key} creados correctamente ------------------" -ForegroundColor Red

    clear
}

# Creacion de Director
$raiz = "ou=Equipo_directivo,ou=elgaleon,dc=ayose,dc=local"
$contrasena = "elgaleon_Director_2024"
$grupo = "grupoDirector"
$usuario = "Director"

Write-Host "------------------ Creacion de "$usuario" -------------------------" -ForegroundColor Red

New-ADOrganizationalUnit -Name "${usuario}" -Path "${raiz}"
New-ADGroup -Name "${grupo}" -SamAccountName "${grupo}" -GroupScope Global -GroupCategory Security -Path "ou=${usuario},${raiz}"

Write-Host "El grupo ${grupo} ha sido creado correctamente" -ForegroundColor Green

New-ADUser -Name "${usuario}" -UserPrincipalName "${usuario}@ayose.local" -DisplayName "${usuario}" -Path "ou=${usuario},${raiz}" -AccountPassword (ConvertTo-SecureString "${contrasena}" -AsPlainText -Force)
Add-ADGroupMember -Identity "${grupo}" -Members "${usuario}"

Write-Host "El usuario ${usuario} ha sido creado correctamente"
Start-Sleep -Seconds 1
clear

# Creacion de Vicedirector
$raiz = "ou=Equipo_directivo,ou=elgaleon,dc=ayose,dc=local"
$contrasena = "elgaleon_Vicedirector_2024"
$grupo = "grupoVicedirector"
$usuario = "Vicedirector"

Write-Host "------------------ Creacion de "$usuario" -------------------------" -ForegroundColor Red

New-ADOrganizationalUnit -Name "${usuario}" -Path "${raiz}"
New-ADGroup -Name "${grupo}" -SamAccountName "${grupo}" -GroupScope Global -GroupCategory Security -Path "ou=${usuario},${raiz}"

Write-Host "El grupo ${grupo} ha sido creado correctamente" -ForegroundColor Green

New-ADUser -Name "${usuario}" -UserPrincipalName "${usuario}@ayose.local" -DisplayName "${usuario}" -Path "ou=${usuario},${raiz}" -AccountPassword (ConvertTo-SecureString "${contrasena}" -AsPlainText -Force)
Add-ADGroupMember -Identity "${grupo}" -Members "${usuario}"

Write-Host "El usuario ${usuario} ha sido creado correctamente"
Start-Sleep -Seconds 1
clear

# Creacion de Secretaria
$raiz = "ou=Equipo_directivo,ou=elgaleon,dc=ayose,dc=local"
$contrasena = "elgaleon_Secretaria_2024"
$grupo = "grupoSecretaria"
$usuario = "Secretaria"

Write-Host "------------------ Creacion de "$usuario" -------------------------" -ForegroundColor Red

New-ADOrganizationalUnit -Name "${usuario}" -Path "${raiz}"
New-ADGroup -Name "${grupo}" -SamAccountName "${grupo}" -GroupScope Global -GroupCategory Security -Path "ou=${usuario},${raiz}"

Write-Host "El grupo ${grupo} ha sido creado correctamente" -ForegroundColor Green

New-ADUser -Name "${usuario}" -UserPrincipalName "${usuario}@ayose.local" -DisplayName "${usuario}" -Path "ou=${usuario},${raiz}" -AccountPassword (ConvertTo-SecureString "${contrasena}" -AsPlainText -Force)
Add-ADGroupMember -Identity "${grupo}" -Members "${usuario}"

Write-Host "El usuario ${usuario} ha sido creado correctamente"
Start-Sleep -Seconds 1
clear

# Creacion de Jefes de estudio
$raiz = "ou=Equipo_directivo,ou=elgaleon,dc=ayose,dc=local"
$contrasena = "elgaleon_administracion"
$grupo = "grupoJefesEstudio"
$usuario = "JefeEstudios"
$id = 1
$cantidad = 2

New-ADOrganizationalUnit -Name "JefesEstudio" -Path "${raiz}"
New-ADGroup -Name "${grupo}" -SamAccountName "${grupo}" -GroupScope Global -GroupCategory Security -Path "ou=JefesEstudio,${raiz}"
for ($variable = 1; $variable -le $cantidad; $variable++) {

    Write-Host "------------------ Creacion de "${usuario}${id}" -------------------------" -ForegroundColor Red

    Write-Host "El grupo ${grupo} ha sido creado correctamente" -ForegroundColor Green

    New-ADUser -Name "${usuario}${id}" -UserPrincipalName "${usuario}${id}@ayose.local" -DisplayName "${usuario}${id}" -Path "ou=JefesEstudio,${raiz}" -AccountPassword (ConvertTo-SecureString "${contrasena}${id}" -AsPlainText -Force)
    Add-ADGroupMember -Identity "${grupo}" -Members "${usuario}${id}"

    Write-Host "El usuario ${usuario}${id} ha sido creado correctamente"
    Start-Sleep -Seconds 1
    $id++

    clear
}

# Creacion de Cafeteria
$raiz = "ou=Personal_cafeteria,ou=Personal_laboral,ou=elgaleon,dc=ayose,dc=local"
$contrasena = "elgaleon_cafeteria"
$grupo = "grupoCafeteria"
$usuario = "TrabajadorCafeteria"
$id = 1
$cantidad = 2

New-ADGroup -Name "${grupo}" -SamAccountName "${grupo}" -GroupScope Global -GroupCategory Security -Path "${raiz}"
for ($variable = 1; $variable -le $cantidad; $variable++) {

    Write-Host "------------------ Creacion de "${usuario}${id}" -------------------------" -ForegroundColor Red

    Write-Host "El grupo ${grupo} ha sido creado correctamente" -ForegroundColor Green

    New-ADUser -Name "${usuario}${id}" -UserPrincipalName "${usuario}${id}@ayose.local" -DisplayName "${usuario}${id}" -Path "${raiz}" -AccountPassword (ConvertTo-SecureString "${contrasena}${id}" -AsPlainText -Force)
    Add-ADGroupMember -Identity "${grupo}" -Members "${usuario}${id}"

    Write-Host "El usuario ${usuario}${id} ha sido creado correctamente"
    Start-Sleep -Seconds 1
    $id++
    
    clear
}

# Creacion de Limpieza
$raiz = "ou=Personal_limpieza,ou=Personal_laboral,ou=elgaleon,dc=ayose,dc=local"
$contrasena = "elgaleon_limpieza"
$grupo = "grupoLimpieza"
$usuario = "TrabajadorLimpieza"
$id = 1
$cantidad = 4

New-ADGroup -Name "${grupo}" -SamAccountName "${grupo}" -GroupScope Global -GroupCategory Security -Path "${raiz}"
for ($variable = 1; $variable -le $cantidad; $variable++) {

    Write-Host "------------------ Creacion de "${usuario}${id}" -------------------------" -ForegroundColor Red

    Write-Host "El grupo ${grupo} ha sido creado correctamente" -ForegroundColor Green

    New-ADUser -Name "${usuario}${id}" -UserPrincipalName "${usuario}${id}@ayose.local" -DisplayName "${usuario}${id}" -Path "${raiz}" -AccountPassword (ConvertTo-SecureString "${contrasena}${id}" -AsPlainText -Force)
    Add-ADGroupMember -Identity "${grupo}" -Members "${usuario}${id}"

    Write-Host "El usuario ${usuario}${id} ha sido creado correctamente"
    Start-Sleep -Seconds 1
    $id++
    
    clear
}

# Creacion de Administrativos
$raiz = "ou=Personal_administrativo,ou=elgaleon,dc=ayose,dc=local"
$contrasena = "elgaleon_administracion"
$grupo = "grupoAdministracion"
$usuario = "TrabajadorAdmin"
$id = 1
$cantidad = 6

New-ADGroup -Name "${grupo}" -SamAccountName "${grupo}" -GroupScope Global -GroupCategory Security -Path "${raiz}"
for ($variable = 1; $variable -le $cantidad; $variable++) {

    Write-Host "------------------ Creacion de "${usuario}${id}" -------------------------" -ForegroundColor Red

    Write-Host "El grupo ${grupo} ha sido creado correctamente" -ForegroundColor Green

    New-ADUser -Name "${usuario}${id}" -UserPrincipalName "${usuario}${id}@ayose.local" -DisplayName "${usuario}${id}" -Path "${raiz}" -AccountPassword (ConvertTo-SecureString "${contrasena}${id}" -AsPlainText -Force)
    Add-ADGroupMember -Identity "${grupo}" -Members "${usuario}${id}"

    Write-Host "El usuario ${usuario}${id} ha sido creado correctamente"
    Start-Sleep -Seconds 1
    $id++
    
    clear
}
CrearTodo_2
