mergeInto(LibraryManager.library, {
    // this is called as JSPI_IMPORTS
    fetchmono: async function () {
        const res = await fetch("index.html");

        // re-enter C
        _remono();

        const text = await res.text();

        // convert to char*
        const ptr = _malloc(text.length*2 + 1);
        stringToUTF8(text, ptr, text.length + 1);

        return ptr;
    }
});
