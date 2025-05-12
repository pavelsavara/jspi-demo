import HelloModule from './hello.js';

// Function to run the program and display output
async function runProgram() {
    const module = await HelloModule();

    // this is calling JSPI_EXPORTS
    await module._mono();
}

// Add event listener to the button
document.getElementById('runButton').addEventListener('click', runProgram);
