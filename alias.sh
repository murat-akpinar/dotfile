echo "alias ll='ls -lvrt'" >> ~/.profile
echo "alias cdd='cd ..'" >> ~/.profile
echo "alias cddd='cd ../..'" >> ~/.profile

echo "alias bcat='batcat'" >> ~/.profile
echo "alias ara='find . -print0 | xargs -0 stat -c "%Z %z %n" | sort -nr | head -10'" >> ~/.profile


source ~/.profile

