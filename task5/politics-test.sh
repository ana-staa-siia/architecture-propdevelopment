# 1. РАЗРЕШЕННЫЙ: front-end → back-end-api
kubectl run test-front --rm -i --restart=Never --image=alpine -l role=front-end -n app-namespace -- sh -c 'wget -qO- --timeout=5 http://back-end-api-app && echo "SUCCESS: front-end can access back-end-api" || echo "FAILED"'

# 2. РАЗРЕШЕННЫЙ: admin-front-end → admin-back-end-api
kubectl run test-admin --rm -i --restart=Never --image=alpine -l role=admin-front-end -n app-namespace -- sh -c 'wget -qO- --timeout=5 http://admin-back-end-api-app && echo "SUCCESS: admin-front-end can access admin-back-end-api" || echo "FAILED"'

# 3. ЗАПРЕЩЕННЫЙ: front-end → admin-back-end-api
kubectl run test-cross1 --rm -i --restart=Never --image=alpine -l role=front-end -n app-namespace -- sh -c 'wget -qO- --timeout=5 http://admin-back-end-api-app && echo "FAIL: Should be blocked!" || echo "SUCCESS: Correctly blocked"'

# 4. ЗАПРЕЩЕННЫЙ: admin-front-end → back-end-api
kubectl run test-cross2 --rm -i --restart=Never --image=alpine -l role=admin-front-end -n app-namespace -- sh -c 'wget -qO- --timeout=5 http://back-end-api-app && echo "FAIL: Should be blocked!" || echo "SUCCESS: Correctly blocked"'

# 5. ЗАПРЕЩЕННЫЙ: любой другой под → back-end-api
kubectl run test-other --rm -i --restart=Never --image=alpine -n app-namespace -- sh -c 'wget -qO- --timeout=5 http://back-end-api-app && echo "FAIL: Should be blocked!" || echo "SUCCESS: Correctly blocked"'