#!/bin/bash

while true; do
  read -p "Enter package name: " pkg
  read -p "Enter npm username: " user

  if [ -d "$pkg" ]; then
    cd "$pkg"
  else
    mkdir "$pkg"
    cd "$pkg"
  fi

  if [ -f "package.json" ]; then
    mv "package.json" "package.json.bak"
  fi

  if [ -f "README.md" ]; then
    mv "README.md" "README.md.bak"
  fi

  if [ -f "LICENSE.md" ]; then
    mv "LICENSE.md" "LICENSE.md.bak"
  fi

  touch "README.md"
  echo "# $pkg" >>"README.md"
  echo "" >>"README.md"
  echo "Homepage: https://github.com/gannonh/$pkg#readme" >>"README.md"

  touch "LICENSE.md"
  echo "MIT License" >>"LICENSE.md"
  echo "" >>"LICENSE.md"
  echo "Copyright (c) 2023 @gannonh" >>"LICENSE.md"
  echo "" >>"LICENSE.md"
  echo "Permission is hereby granted, free of charge, to any person obtaining a copy" >>"LICENSE.md"
  echo "of this software and associated documentation files (the \"Software\"), to deal" >>"LICENSE.md"
  echo "in the Software without restriction, including without limitation the rights" >>"LICENSE.md"
  echo "to use, copy, modify, merge, publish, distribute, sublicense, and/or sell" >>"LICENSE.md"
  echo "copies of the Software, and to permit persons to whom the Software is" >>"LICENSE.md"
  echo "furnished to do so, subject to the following conditions:" >>"LICENSE.md"
  echo "" >>"LICENSE.md"
  echo "The above copyright notice and this permission notice shall be included in all" >>"LICENSE.md"
  echo "copies or substantial portions of the Software." >>"LICENSE.md"
  echo "" >>"LICENSE.md"
  echo "THE SOFTWARE IS PROVIDED \"AS IS\", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR" >>"LICENSE.md"
  echo "IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY," >>"LICENSE.md"
  echo "FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE" >>"LICENSE.md"
  echo "AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER" >>"LICENSE.md"
  echo "LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM," >>"LICENSE.md"
  echo "OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE" >>"LICENSE.md"

  echo "package.json.bak" >>".gitignore"
  echo "README.md.bak" >>".gitignore"
  echo "LICENSE.md.bak" >>".gitignore"

  cd ../
  gh repo create $pkg --public --clone

  cd "$pkg"
  npm init --scope=@$user
  npm publish --access public

  # create the package.json file
  touch package.json

  # add the content to the package.json file
  echo "{
    \"name\": \"@$user/$pkg\",
    \"version\": \"1.0.0\",
    \"main\": \"dist/cjs.js\",
    \"module\": \"dist/esm.js\",
    \"generativeFmManifest\": \"$pkg.gfm.manifest.json\",
    \"files\": [
      \"dist\",
      \"image.png\",
      \"$pkg.gfm.manifest.json\"
    ],
    \"author\": \"$user\",
    \"license\": \"MIT\",
    \"devDependencies\": {
      \"@babel/plugin-transform-runtime\": \"^7.12.1\",
      \"rollup-plugin-json\": \"^3.1.0\"
    },
    \"dependencies\": {
      \"@babel/runtime\": \"^7.12.5\",
      \"@$user/utilities\": \"^5.2.0\",
      \"markov-chains\": \"^1.0.2\"
    },
    \"peerDependencies\": {
      \"tone\": \"^14.7.39\"
    },
    \"unpkg\": \"dist/umd.min.js\",
    \"scripts\": {
      \"test\": \"echo \\\"Error: no test specified\\\" && exit 1\"
    },
    \"repository\": {
      \"type\": \"git\",
      \"url\": \"git://github.com/gannonh/$pkg.git\"
    },
    \"bugs\": {
      \"url\": \"https://github.com/gannonh/$pkg/issues\"
    },
    \"homepage\": \"https://github.com/gannonh/$pkg#readme\"
  }" > package.json

  cd ../

  echo "The following operations were completed:"
  echo "- Changed to directory $pkg"
  echo "- Renamed file package.json to package.json.bak"
  echo "- Created .gitignore file and added .bak files"
  echo "- Created README.md file"
  echo "- Created LICENSE.md file"
  echo "- Added MIT license to LICENSE.md file"
  echo "- Executed git init"
  echo "- Executed git remote add origin git://github.com/gannonh/$pkg"
  echo "- Executed npm init --scope=@$user"
  echo "- Executed npm publish --access public"
  echo "- Changed to parent directory"

  read -p "Would you like to continue? (y/n) " choice
  if [ "$choice" == "n" ]; then
    echo "ok, done for now."
    break
  fi
done