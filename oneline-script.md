- Nohub
```bash
# Bash
nohup bash -c "komut" |& tee -a nohup.log > /dev/null & echo "Process started with PID: $!" | tee -a nohup.log > /dev/null; disown
# Fish
nohup bash -c "komut" |& tee -a nohup.log > /dev/null & echo "Process started with PID: $last_pid" | tee -a nohup.log > /dev/null; disown
```
