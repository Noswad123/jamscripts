#!/usr/bin/env node

const fs = require('fs');
const path = require('path');

// Function to get parent folder name
function getParentFolderName() {
    // Get the full path of the parent directory
    const parentDir = path.resolve(process.cwd());
    // Extract the name of the parent folder
    return path.basename(parentDir);
}

// Function to create or update the index.ts file
function createOrUpdateIndexFile() {
    // Get the parent folder name
    const parentFolderName = getParentFolderName();
    // Define the content to be written to the index.ts file
    const content = `export * from './${parentFolderName}-modal.component';\n`;
    // Define the path of the index.ts file
    const filePath = path.join(process.cwd(), 'index.ts');

    // Write the content to the index.ts file
    fs.writeFile(filePath, content, (err) => {
        if (err) {
            console.error('Error writing to index.ts:', err);
            return;
        }
        console.log('index.ts has been updated successfully!');
    });
}

createOrUpdateIndexFile();

