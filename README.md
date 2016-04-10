# freebsd-packer

`freebsd-packer` is a packer manifest for building a minimal FreeBSD installation.
The current set is based on **10.3-RELEASE**.

## Vagrant boxes (Artifacts)

The box build artifacts can be found on HashiCorp Atlas:

* https://atlas.hashicorp.com/dprandzioch/boxes/freebsd-10_3-minimal
* https://atlas.hashicorp.com/dprandzioch/boxes/freebsd-10_2-minimal

## Build it yourself

First, just install `packer`. If you use OS X and Homebrew, just run:

```bash
$ brew install packer
```

Then build the box based on it's template. You might wanna remove the
`post-processors` node for Atlas to have the box not being pushed to Atlas.

```bash
$ packer push template.json
```

## License

```
Copyright (c) 2016 David Prandzioch


Permission is hereby granted, free of charge, to any person obtaining a copy of
this software and associated documentation files (the "Software"), to deal in
the Software without restriction, including without limitation the rights to
use, copy, modify, merge, publish, distribute, sublicense, and/or sell copies
of the Software, and to permit persons to whom the Software is furnished to
do so, subject to the following conditions:

The above copyright notice and this permission notice shall be included in all
copies or substantial portions of the Software.

THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY, FITNESS
FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE AUTHORS OR
COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY, WHETHER
IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM, OUT OF OR IN
CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE SOFTWARE.
```
