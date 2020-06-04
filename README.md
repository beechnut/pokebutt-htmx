# Pokebutt in HTMX

This Pokebutt app is a clone of Laura Do's original [Pokebutt](https://pokebutt.herokuapp.com) app.

I learned about [HTMX](https://htmx.org) today and wanted to learn it. As a primarily backend developer, I've needed AJAX-y functionality, and was looking for something lighter than Elm or React. HTMX and a simple webserver did the trick.

This app is written in HTMX and Ruby (Sinatra).

Pluses:

- Feels faster than the original React Pokebutt (though I don't have benchmarks to back that up).
- Very tiny app (60-ish lines of code)

Deltas:

- Doesn't yet handle Pokemon genders (specifically Nidoran).
- There's an opportunity to use partials to update the DOM, but because out-of-band updates require the `hx-swap-oob` attribute, they'll have to be dynamic partials.
- Relies on a backend server. Wondering if there's a way to load all the work into the front-end so we don't need a server.
