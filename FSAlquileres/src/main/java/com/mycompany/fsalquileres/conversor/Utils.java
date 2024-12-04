package com.fsalquileres.conversor;

public class Utils {

    // Método para dividir el monto en letras
    public static String[] dividirMontoEnLetras(String montoEnLetras, int limite) {
        // Si el monto es menor que el límite, no es necesario dividirlo
        if (montoEnLetras.length() <= limite) {
            return new String[] { montoEnLetras, "" };  // Solo se devuelve una parte
        }

        // Buscar el último espacio dentro de los primeros 'limite' caracteres
        int corte = montoEnLetras.lastIndexOf(" ", limite);

        // Si no encontramos un espacio, cortamos directamente en el límite
        if (corte == -1) {
            corte = limite;
        }

        // Retornamos dos partes: la primera con el texto hasta el espacio y la segunda con el resto
        String parte1 = montoEnLetras.substring(0, corte).trim();
        String parte2 = montoEnLetras.substring(corte).trim();

        return new String[] { parte1, parte2 };
    }
}
