# makeFFVCpackage
Scripts to make ffvc_package

### Memo

- ffvc_install_templateがひな形  

`$ ffvc-isg.sh ffvc_install_template intel|gnu|fx`

`$ ./ffvc-isg.sh` でないことに注意！

- 上記の自動化  
`$ ./ffvc_generate_install-script.sh`

- 上記の全ての自動化（例えば，version 1.6.2の作成）  
`$ mk-ffvc-package.sh 1.6.2`
