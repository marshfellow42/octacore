pragma Singleton
import Quickshell
import Quickshell.Io
import QtQuick
import qs.theme

Singleton {
    id: root

    property var table: ({})   // { key: { en: "...", pt_BR: "..." } }

    // Reading `table` and `language` inside tr() makes bindings re-evaluate
    // when either changes, so the UI updates live.
    function tr(key) {
        const translations = table[key];
        if (!translations) {
            return key;
        }
        return translations[Layout.general.locale] || translations["en"] || key;
    }

    // Small CSV parser that handles quoted fields, commas inside quotes, and "" escapes
    function parseCsv(csvText) {
        const parsedRows = [];
        let currentRow = [];
        let currentField = "";
        let insideQuotes = false;

        for (let charIndex = 0; charIndex < csvText.length; charIndex++) {
            const character = csvText[charIndex];

            if (insideQuotes) {
                if (character === '"' && csvText[charIndex + 1] === '"') {
                    currentField += '"';
                    charIndex++;
                } else if (character === '"') {
                    insideQuotes = false;
                } else {
                    currentField += character;
                }
            } else if (character === '"') {
                insideQuotes = true;
            } else if (character === ",") {
                currentRow.push(currentField);
                currentField = "";
            } else if (character === "\n" || character === "\r") {
                if (character === "\r" && csvText[charIndex + 1] === "\n") {
                    charIndex++;
                }
                currentRow.push(currentField);
                currentField = "";
                if (currentRow.some(cellValue => cellValue !== "")) {
                    parsedRows.push(currentRow);
                }
                currentRow = [];
            } else {
                currentField += character;
            }
        }

        // Flush the last row if the file doesn't end with a newline
        currentRow.push(currentField);
        if (currentRow.some(cellValue => cellValue !== "")) {
            parsedRows.push(currentRow);
        }
        return parsedRows;
    }

    FileView {
        path: Quickshell.shellPath("i18n/i18n.csv")
        watchChanges: true
        onFileChanged: reload()
        onLoaded: {
            const csvRows = root.parseCsv(text());
            const headerRow = csvRows[0];
            const newTable = {};

            for (let rowIndex = 1; rowIndex < csvRows.length; rowIndex++) {
                const translations = {};
                for (let columnIndex = 1; columnIndex < headerRow.length; columnIndex++) {
                    const languageCode = headerRow[columnIndex];
                    translations[languageCode] = csvRows[rowIndex][columnIndex];
                }
                const translationKey = csvRows[rowIndex][0];
                newTable[translationKey] = translations;
            }
            root.table = newTable;
        }
    }
}